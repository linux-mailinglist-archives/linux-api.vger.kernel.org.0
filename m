Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEE8CE723A
	for <lists+linux-api@lfdr.de>; Mon, 28 Oct 2019 14:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729448AbfJ1NA1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 28 Oct 2019 09:00:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:44120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbfJ1NA1 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 28 Oct 2019 09:00:27 -0400
Received: from rapoport-lnx (unknown [91.217.168.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4CD220873;
        Mon, 28 Oct 2019 13:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572267626;
        bh=7B5KqT02XX9UUIrQVYUjxF/tdp4AX2fxoquk/g1eYlg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W+ACpEJtAVmweITcDAONS+d676IgPfKwQtn05LXqUIkznSdTZHf+QRrS2253omIX6
         f4YsmExVRa7lT6Sble5zHX+YPVeEOxeSUnSA2MCF1zYGfMN7ZbZtMsP1sGncjGcRyA
         H1P+eY3WBy01O4yAzuWeWSC4E50ZtAkaNQbdeAzo=
Date:   Mon, 28 Oct 2019 14:00:19 +0100
From:   Mike Rapoport <rppt@kernel.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-kernel@vger.kernel.org,
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
Message-ID: <20191028130018.GA7192@rapoport-lnx>
References: <1572171452-7958-1-git-send-email-rppt@kernel.org>
 <1572171452-7958-2-git-send-email-rppt@kernel.org>
 <20191028123124.ogkk5ogjlamvwc2s@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028123124.ogkk5ogjlamvwc2s@box>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Oct 28, 2019 at 03:31:24PM +0300, Kirill A. Shutemov wrote:
> On Sun, Oct 27, 2019 at 12:17:32PM +0200, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > The mappings created with MAP_EXCLUSIVE are visible only in the context of
> > the owning process and can be used by applications to store secret
> > information that will not be visible not only to other processes but to the
> > kernel as well.
> > 
> > The pages in these mappings are removed from the kernel direct map and
> > marked with PG_user_exclusive flag. When the exclusive area is unmapped,
> > the pages are mapped back into the direct map.
> 
> I probably blind, but I don't see where you manipulate direct map...

__get_user_pages() calls __set_page_user_exclusive() which in turn calls
set_direct_map_invalid_noflush() that makes the page not present.
 
> -- 
>  Kirill A. Shutemov

-- 
Sincerely yours,
Mike.
