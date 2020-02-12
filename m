Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9F7415B280
	for <lists+linux-api@lfdr.de>; Wed, 12 Feb 2020 22:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbgBLVKb (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Feb 2020 16:10:31 -0500
Received: from ms.lwn.net ([45.79.88.28]:59066 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727420AbgBLVKb (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 12 Feb 2020 16:10:31 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 94C40740;
        Wed, 12 Feb 2020 21:10:30 +0000 (UTC)
Date:   Wed, 12 Feb 2020 14:10:29 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mike Rapoport <rppt@kernel.org>
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
Message-ID: <20200212141029.7b89acee@lwn.net>
In-Reply-To: <20200130162340.GA14232@rapoport-lnx>
References: <20200130162340.GA14232@rapoport-lnx>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, 30 Jan 2020 18:23:41 +0200
Mike Rapoport <rppt@kernel.org> wrote:

> Hi,
> 
> This is essentially a resend of my attempt to implement "secret" mappings
> using a file descriptor [1]. 

So one little thing I was curious about as I read through the patch...

> +static int secretmem_check_limits(struct vm_fault *vmf)
> +{
> +	struct secretmem_state *state = vmf->vma->vm_file->private_data;
> +	struct inode *inode = file_inode(vmf->vma->vm_file);
> +	unsigned long limit;
> +
> +	if (((loff_t)vmf->pgoff << PAGE_SHIFT) >= i_size_read(inode))
> +		return -EINVAL;
> +
> +	limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> +	if (state->nr_pages + 1 >= limit)
> +		return -EPERM;
> +
> +	return 0;
> +}

If I'm not mistaken, this means each memfd can be RLIMIT_MEMLOCK in length,
with no global limit on the number of locked pages.  What's keeping me from
creating 1000 of these things and locking down lots of RAM?

Thanks,

jon

