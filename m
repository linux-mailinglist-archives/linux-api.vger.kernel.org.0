Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2E5223728
	for <lists+linux-api@lfdr.de>; Fri, 17 Jul 2020 10:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgGQIgH (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 17 Jul 2020 04:36:07 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:56568 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgGQIgF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 17 Jul 2020 04:36:05 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id D8FF61C0BDF; Fri, 17 Jul 2020 10:36:02 +0200 (CEST)
Date:   Fri, 17 Jul 2020 10:36:02 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Alan Cox <alan@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Idan Yaniv <idan.yaniv@ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [RFC PATCH v2 0/5] mm: extend memfd with ability to create
 "secret" memory areas
Message-ID: <20200717083601.GB1027@bug>
References: <20200706172051.19465-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706172051.19465-1-rppt@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi!

> This is a second version of "secret" mappings implementation backed by a
> file descriptor. 
> 
> The file descriptor is created using memfd_create() syscall with a new
> MFD_SECRET flag. The file descriptor should be configured using ioctl() to
> define the desired protection and then mmap() of the fd will create a
> "secret" memory mapping. The pages in that mapping will be marked as not
> present in the direct map and will have desired protection bits set in the
> user page table. For instance, current implementation allows uncached
> mappings.
> 
> Hiding secret memory mappings behind an anonymous file allows (ab)use of
> the page cache for tracking pages allocated for the "secret" mappings as
> well as using address_space_operations for e.g. page migration callbacks.
> 
> The anonymous file may be also used implicitly, like hugetlb files, to
> implement mmap(MAP_SECRET) and use the secret memory areas with "native" mm
> ABIs.

I believe unix userspace normally requires mappings to be... well... protected from
other users. How is this "secret" thing different? How do you explain the difference
to userland programmers?

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
