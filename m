Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81D7CE8529
	for <lists+linux-api@lfdr.de>; Tue, 29 Oct 2019 11:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfJ2KMF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 29 Oct 2019 06:12:05 -0400
Received: from gentwo.org ([3.19.106.255]:37920 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbfJ2KMF (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 29 Oct 2019 06:12:05 -0400
Received: by gentwo.org (Postfix, from userid 1002)
        id 199B33EF15; Tue, 29 Oct 2019 10:12:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 1877F3EF14;
        Tue, 29 Oct 2019 10:12:04 +0000 (UTC)
Date:   Tue, 29 Oct 2019 10:12:04 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Mike Rapoport <rppt@kernel.org>
cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
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
In-Reply-To: <20191029085551.GA18773@rapoport-lnx>
Message-ID: <alpine.DEB.2.21.1910291011090.5411@www.lameter.com>
References: <1572171452-7958-1-git-send-email-rppt@kernel.org> <1572171452-7958-2-git-send-email-rppt@kernel.org> <20191028123124.ogkk5ogjlamvwc2s@box> <20191028130018.GA7192@rapoport-lnx> <20191028131623.zwuwguhm4v4s5imh@box> <alpine.DEB.2.21.1910290706360.3769@www.lameter.com>
 <20191029085551.GA18773@rapoport-lnx>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



On Tue, 29 Oct 2019, Mike Rapoport wrote:

> I've talked with Thomas yesterday and he suggested something similar:
>
> When the MAP_EXCLUSIVE request comes for the first time, we allocate a huge
> page for it and then use this page as a pool of 4K pages for subsequent
> requests. Once this huge page is full we allocate a new one and append it
> to the pool. When all the 4K pages that comprise the huge page are freed
> the huge page is collapsed.

Or write a device driver that allows you to mmap a secure area and avoid
all core kernel modifications?

/dev/securemem or so?

It may exist already.

