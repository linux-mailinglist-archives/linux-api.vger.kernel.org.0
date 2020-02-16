Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF33160244
	for <lists+linux-api@lfdr.de>; Sun, 16 Feb 2020 07:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbgBPGq7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 16 Feb 2020 01:46:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:46282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbgBPGq7 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sun, 16 Feb 2020 01:46:59 -0500
Received: from hump.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 400CF20659;
        Sun, 16 Feb 2020 06:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581835618;
        bh=0Glmy2rHz9Nf2Jk6JgoRKqRnT6KMFXNB47KY1ashgzA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FeIN6dVVEIRThZ2RgK/fA7L8n90zXVh6xftACf3uAvtFfHrlNAPq66yQ1RfEX3fJT
         XEbXDLFzjWyFXbnapOP1OCC3WbScqsUtAPrQi5qvRmLQscnMJO1AWyavFd4VwQi5/L
         51D+zQAcS/gs6QwAQIZBdOE9r22m+xCJtA/hvX7w=
Date:   Sun, 16 Feb 2020 08:46:50 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, Alan Cox <alan@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, linux-api@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH] mm: extend memfd with ability to create "secret"
 memory areas
Message-ID: <20200216064650.GB22092@hump.haifa.ibm.com>
References: <20200130162340.GA14232@rapoport-lnx>
 <20200212141029.7b89acee@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212141029.7b89acee@lwn.net>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Feb 12, 2020 at 02:10:29PM -0700, Jonathan Corbet wrote:
> On Thu, 30 Jan 2020 18:23:41 +0200
> Mike Rapoport <rppt@kernel.org> wrote:
> 
> > Hi,
> > 
> > This is essentially a resend of my attempt to implement "secret" mappings
> > using a file descriptor [1]. 
> 
> So one little thing I was curious about as I read through the patch...
> 
> > +static int secretmem_check_limits(struct vm_fault *vmf)
> > +{
> > +	struct secretmem_state *state = vmf->vma->vm_file->private_data;
> > +	struct inode *inode = file_inode(vmf->vma->vm_file);
> > +	unsigned long limit;
> > +
> > +	if (((loff_t)vmf->pgoff << PAGE_SHIFT) >= i_size_read(inode))
> > +		return -EINVAL;
> > +
> > +	limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> > +	if (state->nr_pages + 1 >= limit)
> > +		return -EPERM;
> > +
> > +	return 0;
> > +}
> 
> If I'm not mistaken, this means each memfd can be RLIMIT_MEMLOCK in length,
> with no global limit on the number of locked pages.  What's keeping me from
> creating 1000 of these things and locking down lots of RAM?

Indeed, it's possible to lock down RLIMIT_MEMLOCK * RLIMIT_NOFILE of RAM
with this implementation, thanks for catching this.

I'll surely update the resource limiting once we've settle on the API
selection :)
 
> Thanks,
> 
> jon
> 

-- 
Sincerely yours,
Mike.
