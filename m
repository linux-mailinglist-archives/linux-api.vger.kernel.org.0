Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3E722CCFEF
	for <lists+linux-api@lfdr.de>; Thu,  3 Dec 2020 07:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbgLCG6u (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 3 Dec 2020 01:58:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:46992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgLCG6u (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 3 Dec 2020 01:58:50 -0500
Date:   Thu, 3 Dec 2020 08:58:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1606978689;
        bh=TrahpHtUn6GtqyFBng48QBtZBmbO/ucz4YAA+WbUKig=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=ghQbsZuCi9XwCdX3NAJgSxP/7c1XcmHf/kQRBOIXzOlRecfT6XSTYQYgl5tvlwx6D
         R0SQ+Dw2FdGkfYaqbMk8zDkUTfAWezJfVeqpWK13vz/lge/dC0LiMiJkVnhGgTE0Ty
         9dFdYrskZBgZZCqkgJxmSoPXJA0tvF5BoYCnE3i6d2j6hK/OOmhR8SYA6P928RvKF6
         Ruo96i16CQ13dghMOmpBRz9ioP0mhCzH5OM5/IUJhmRz3oWA//FgYExkptVENDeWvt
         9ZuN8MgMcCGsZx4pYWPD/AIQF1XKrLbtoIh7YggGewNqT45S5NeO60FA2sZmb++1Lz
         yYIfGJawsZuUA==
From:   Mike Rapoport <rppt@kernel.org>
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     linux-hardening@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] mm/vmalloc: randomize vmalloc() allocations
Message-ID: <20201203065801.GH751215@kernel.org>
References: <20201201214547.9721-1-toiwoton@gmail.com>
 <9d34fb0a-7aba-1e84-6426-006ea7c3d9f5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d34fb0a-7aba-1e84-6426-006ea7c3d9f5@gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Dec 02, 2020 at 08:49:06PM +0200, Topi Miettinen wrote:
> On 1.12.2020 23.45, Topi Miettinen wrote:
> > Memory mappings inside kernel allocated with vmalloc() are in
> > predictable order and packed tightly toward the low addresses. With
> > new kernel boot parameter 'randomize_vmalloc=1', the entire area is
> > used randomly to make the allocations less predictable and harder to
> > guess for attackers.
> > 
> 
> This also seems to randomize module addresses. I was going to check that
> next, so nice surprise!

Heh, that's because module_alloc() uses vmalloc() in that way or another :)

> -Topi
> 
> >   	spin_unlock(&free_vmap_area_lock);
> >   	if (unlikely(addr == vend))
> > 
> 

-- 
Sincerely yours,
Mike.
