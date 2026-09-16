#!/usr/bin/env python3
"""
Extract resume data from markdown and convert to JSON for Typst processing.
"""

import re
import json
import sys
from pathlib import Path
from typing import Dict, List, Any


def parse_markdown_resume(content: str) -> Dict[str, Any]:
    """Parse the markdown resume content into structured data."""
    
    # Remove TOML frontmatter
    content = re.sub(r'^\+\+\+.*?\+\+\+\s*', '', content, flags=re.DOTALL)
    
    # Split by sections (## headers)
    sections = re.split(r'^## (.+)$', content, flags=re.MULTILINE)
    
    resume_data = {
        "sections": {},
        "name": "Max Farrell",  # Could be extracted from frontmatter
        "contact": {
            "location": "Austin, TX",
            "linkedin": "linkedin.com/in/maxffarrell",
            "github": "github.com/maxffarrell"
        }
    }
    
    # Parse sections
    current_section = None
    for i, part in enumerate(sections):
        if i == 0:
            continue  # Skip content before first section
        
        if i % 2 == 1:  # Section header
            current_section = part.strip()
            resume_data["sections"][current_section] = {"content": "", "items": []}
        else:  # Section content
            if current_section:
                resume_data["sections"][current_section]["content"] = part.strip()
                
                # Extract location from About Me section
                if current_section == "About Me":
                    location_match = re.search(r'\*\*Location:\*\*\s*(.+)', part)
                    if location_match:
                        resume_data["contact"]["location"] = location_match.group(1).strip()
                
                # Parse experience/project items
                if current_section in ["Experience", "Projects", "Education"]:
                    items = parse_section_items(part.strip())
                    resume_data["sections"][current_section]["items"] = items
    
    return resume_data


def parse_section_items(content: str) -> List[Dict[str, Any]]:
    """Parse experience/project items from section content."""
    items = []
    lines = content.split('\n')
    
    current_item = None
    
    for line in lines:
        line = line.strip()
        
        # Check for job header pattern: **Company** • Role (Dates)
        job_match = re.match(r'\*\*(.+?)\*\*\s*•\s*(.+)', line)
        if job_match:
            # Save previous item
            if current_item:
                items.append(current_item)
            
            company = job_match.group(1).strip()
            role_and_dates = job_match.group(2).strip()
            
            # Extract dates from role
            date_match = re.search(r'\(([^)]+)\)$', role_and_dates)
            if date_match:
                dates = date_match.group(1)
                role = role_and_dates[:date_match.start()].strip()
            else:
                role = role_and_dates
                dates = ""
            
            current_item = {
                "company": company,
                "role": role,
                "dates": dates,
                "description": []
            }
        
        # Check for simple company name without role
        elif re.match(r'\*\*(.+?)\*\*$', line):
            # Save previous item
            if current_item:
                items.append(current_item)
            
            company = re.match(r'\*\*(.+?)\*\*$', line).group(1).strip()
            current_item = {
                "company": company,
                "role": "",
                "dates": "",
                "description": []
            }
        
        # Check for bullet points
        elif line.startswith('- ') and current_item:
            bullet = line[2:].strip()
            current_item["description"].append(bullet)
    
    # Add the last item
    if current_item:
        items.append(current_item)
    
    return items


def main():
    """Main function to process resume markdown."""
    if len(sys.argv) != 3:
        print("Usage: extract_resume_data.py <input_md> <output_json>")
        sys.exit(1)
    
    input_file = Path(sys.argv[1])
    output_file = Path(sys.argv[2])
    
    if not input_file.exists():
        print(f"Error: Input file {input_file} does not exist")
        sys.exit(1)
    
    # Read and parse the markdown
    content = input_file.read_text(encoding='utf-8')
    resume_data = parse_markdown_resume(content)
    
    # Write JSON output
    with open(output_file, 'w', encoding='utf-8') as f:
        json.dump(resume_data, f, indent=2, ensure_ascii=False)
    
    print(f"Resume data extracted to {output_file}")


if __name__ == "__main__":
    main()