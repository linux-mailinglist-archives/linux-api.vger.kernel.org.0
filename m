Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03272E81D8
	for <lists+linux-api@lfdr.de>; Tue, 29 Oct 2019 08:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfJ2HIo (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 29 Oct 2019 03:08:44 -0400
Received: from gentwo.org ([3.19.106.255]:37848 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbfJ2HIo (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 29 Oct 2019 03:08:44 -0400
Received: by gentwo.org (Postfix, from userid 1002)
        id D5B1F3EF13; Tue, 29 Oct 2019 07:08:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id D4C183EA21;
        Tue, 29 Oct 2019 07:08:42 +0000 (UTC)
Date:   Tue, 29 Oct 2019 07:08:42 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
cc:     Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
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
In-Reply-To: <20191028131623.zwuwguhm4v4s5imh@box>
Message-ID: <alpine.DEB.2.21.1910290706360.3769@www.lameter.com>
References: <1572171452-7958-1-git-send-email-rppt@kernel.org> <1572171452-7958-2-git-send-email-rppt@kernel.org> <20191028123124.ogkk5ogjlamvwc2s@box> <20191028130018.GA7192@rapoport-lnx> <20191028131623.zwuwguhm4v4s5imh@box>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, 28 Oct 2019, Kirill A. Shutemov wrote:

> Setting a single 4k page non-present in the direct mapping will require
> splitting 2M or 1G page we usually map direct mapping with. And it's one
> way road. We don't have any mechanism to map the memory with huge page
> again after the application has freed the page.
>
> It might be okay if all these pages cluster together, but I don't think we
> have a way to achieve it easily.

Set aside a special physical memory range for this and migrate the
page to that physical memory range when MAP_EXCLUSIVE is specified?

Maybe some processors also have hardware ranges that offer additional
protection for stuff like that?
