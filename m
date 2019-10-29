Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9231E86BE
	for <lists+linux-api@lfdr.de>; Tue, 29 Oct 2019 12:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbfJ2LZS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Tue, 29 Oct 2019 07:25:18 -0400
Received: from mga14.intel.com ([192.55.52.115]:54309 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbfJ2LZS (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 29 Oct 2019 07:25:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 04:25:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,243,1569308400"; 
   d="scan'208";a="203537076"
Received: from irsmsx151.ger.corp.intel.com ([163.33.192.59])
  by orsmga006.jf.intel.com with ESMTP; 29 Oct 2019 04:25:14 -0700
Received: from irsmsx112.ger.corp.intel.com (10.108.20.5) by
 IRSMSX151.ger.corp.intel.com (163.33.192.59) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 29 Oct 2019 11:25:13 +0000
Received: from irsmsx102.ger.corp.intel.com ([169.254.2.40]) by
 irsmsx112.ger.corp.intel.com ([169.254.1.60]) with mapi id 14.03.0439.000;
 Tue, 29 Oct 2019 11:25:13 +0000
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     Mike Rapoport <rppt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Tycho Andersen <tycho@tycho.ws>,
        Alan Cox <alan@linux.intel.com>
Subject: RE: [PATCH RFC] mm: add MAP_EXCLUSIVE to create exclusive user
 mappings
Thread-Topic: [PATCH RFC] mm: add MAP_EXCLUSIVE to create exclusive user
 mappings
Thread-Index: AQHVjK/LKXzttSiV6ES+HuOmjQLbFqdxS3bQ
Date:   Tue, 29 Oct 2019 11:25:12 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612BA4EEC0CE@IRSMSX102.ger.corp.intel.com>
References: <1572171452-7958-1-git-send-email-rppt@kernel.org>
In-Reply-To: <1572171452-7958-1-git-send-email-rppt@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [163.33.239.181]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

> The patch below aims to allow applications to create mappins that have
> pages visible only to the owning process. Such mappings could be used to
> store secrets so that these secrets are not visible neither to other
> processes nor to the kernel.

Hi Mike, 

I have actually been looking into the closely related problem for the past 
couple of weeks (on and off). What is common here is the need for userspace
to indicate to kernel that some pages contain secrets. And then there are
actually a number of things that kernel can do to try to protect these secrets
better. Unmap from direct map is one of them. Another thing is to map such
pages as non-cached, which can help us to prevent or considerably restrict
speculation on such pages. The initial proof of concept for marking pages as
"UNCACHED" that I got from Dave Hansen was actually based on mlock2() 
and a new flag for it for this purpose. Since then I have been thinking on what
interface suits the use case better and actually selected going with new madvise() 
flag instead because of all possible implications for fragmentation and performance. 
My logic was that we better allocate the secret data explicitly (using mmap()) 
to make sure that no other process data accidentally gets to suffer.
Imagine I would allocate a buffer to hold a secret key, signal with mlock
 to protect it and suddenly my other high throughput non-secret buffer 
(which happened to live on the same page by chance) became very slow
 and I don't even have an easy way (apart from mmap()ing it!) to guarantee
 that it won't be affected.

So, I ended up towards smth like:

  secret_buffer =  mmap(NULL, PAGE_SIZE, ...)
   madvise(secret_buffer, size, MADV_SECRET)

I have work in progress code here:
 https://github.com/ereshetova/linux/commits/madvise

I haven't sent it for review, because it is not ready yet and I am now working
on trying to add the page wiping functionality. Otherwise it would be useless
to protect the page during the time it is used in userspace, but then allow it
to get reused by a different process later after it has been released back and
userspace was stupid enough not to wipe the contents (or was crashed on 
purpose before it was able to wipe anything out). 

We have also had some discussions with Tycho that XPFO can be also
applied selectively for such "SECRET" marked pages and I know that he has also
did some initial prototyping on this, so I think it would be great to decide
on userspace interface first and then see how we can assemble together all
these features. 

The *very* far fetching goal for all of this would be something that Alan Cox
suggested when I started looking into this - actually have a new libc function to 
allocate memory in a secure way, which can hide all the dancing with mmap()/madvise()
(or/and potentially interaction with a chardev that Andy was suggesting also) and
implement an efficient allocator for such secret pages. Openssl has its
own version of  "secure heap", which is essentially mmap area with additional 
MLOCK_ONFAULT and MADV_DONTDUMP flags for protection. Some other 
apps or libs must use smth similar if they want additional protection, which
makes them to reimplement the same concept again and again. Sadly or surprisingly 
other major libs like boringssl, mbedTLS or client like openssh do not user any mlock()/
madvise() flags for any additional protection of secrets that they hold in memory. 
Maybe if all of it would be behind a single secure API situation would start to 
change in userspace towards better. 

Best Regards,
Elena.
 
. 
