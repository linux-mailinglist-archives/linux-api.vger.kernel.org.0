Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D759E9710
	for <lists+linux-api@lfdr.de>; Wed, 30 Oct 2019 08:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbfJ3HLq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 30 Oct 2019 03:11:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:43462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbfJ3HLq (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 30 Oct 2019 03:11:46 -0400
Received: from rapoport-lnx (190.228.71.37.rev.sfr.net [37.71.228.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32A5520874;
        Wed, 30 Oct 2019 07:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572419505;
        bh=L+Zc5GlfgcbUGe7jxxdb2RAXncs48MBZ7tOee6QAN9U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VLe5bn2ysOr1LFizjdvtRzqnw6w/qP4cy8721MX6qc21c54PKgBcQOPj/vGxd6B9y
         5R0IecChBiyW6rGRhVYM3FaX+EEzwYWxMgodHWNKs8LldpbuyxLLKSaMl1Ud/OWcHz
         7yw8UC37KH4Ty1LMPJast9JF/+4ZEAWUMh3awa4o=
Date:   Wed, 30 Oct 2019 08:11:37 +0100
From:   Mike Rapoport <rppt@kernel.org>
To:     Christopher Lameter <cl@linux.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH RFC] mm: add MAP_EXCLUSIVE to create exclusive user
 mappings
Message-ID: <20191030071136.GA20624@rapoport-lnx>
References: <1572171452-7958-1-git-send-email-rppt@kernel.org>
 <1572171452-7958-2-git-send-email-rppt@kernel.org>
 <20191028123124.ogkk5ogjlamvwc2s@box>
 <20191028130018.GA7192@rapoport-lnx>
 <20191028131623.zwuwguhm4v4s5imh@box>
 <alpine.DEB.2.21.1910290706360.3769@www.lameter.com>
 <20191029085551.GA18773@rapoport-lnx>
 <alpine.DEB.2.21.1910291011090.5411@www.lameter.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1910291011090.5411@www.lameter.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Oct 29, 2019 at 10:12:04AM +0000, Christopher Lameter wrote:
> 
> 
> On Tue, 29 Oct 2019, Mike Rapoport wrote:
> 
> > I've talked with Thomas yesterday and he suggested something similar:
> >
> > When the MAP_EXCLUSIVE request comes for the first time, we allocate a huge
> > page for it and then use this page as a pool of 4K pages for subsequent
> > requests. Once this huge page is full we allocate a new one and append it
> > to the pool. When all the 4K pages that comprise the huge page are freed
> > the huge page is collapsed.
> 
> Or write a device driver that allows you to mmap a secure area and avoid
> all core kernel modifications?
> 
> /dev/securemem or so?

A device driver will need to remove the secure area from the direct map and
then we back to square one.
 
> It may exist already.
> 

-- 
Sincerely yours,
Mike.
