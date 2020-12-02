Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5092CC5F9
	for <lists+linux-api@lfdr.de>; Wed,  2 Dec 2020 19:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387760AbgLBSyS (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 2 Dec 2020 13:54:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387903AbgLBSyR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 2 Dec 2020 13:54:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A54C0613D4;
        Wed,  2 Dec 2020 10:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=x7k2lFyLJB5bfb9fPEzXzFBJq+3Mj4qBHsnAWTloKu4=; b=Dju+loNs6iUz8v0bfjzjUmbQ4a
        UL6t4b3LCv0bXx3LCcybXbyCs+QdLkl+Vsa+/HnihsiPhPpIW5Wczaukyozfn9pZIcgi08BwDDLwb
        gwS9p5K1ElOb22EzeWxLMWUGrzkwqkP8/k4XQSe/ZJkld40dVsuz5Cidy1dEHk3JvWQwV502ra8iw
        6s5uep//lxA8cphkUuDZK3HfjX135eCF96j1aLBNupUEiJXv0q6LViNsoBcvf0f7Ghe0wVo2XSAkS
        RCWi2QGeu+8qB+WIY02RsAQe+EL487YBClM6XRRMEVRPckmQHGFoOt9EzxZILGo6yxPsft7VKRJLw
        41k6blcQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kkXFu-0004eS-PH; Wed, 02 Dec 2020 18:53:34 +0000
Date:   Wed, 2 Dec 2020 18:53:34 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     linux-hardening@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH] mm/vmalloc: randomize vmalloc() allocations
Message-ID: <20201202185334.GG11935@casper.infradead.org>
References: <20201201214547.9721-1-toiwoton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201214547.9721-1-toiwoton@gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Dec 01, 2020 at 11:45:47PM +0200, Topi Miettinen wrote:
> +	/* Randomize allocation */
> +	if (randomize_vmalloc) {
> +		voffset = get_random_long() & (roundup_pow_of_two(vend - vstart) - 1);
> +		voffset = PAGE_ALIGN(voffset);
> +		if (voffset + size > vend - vstart)
> +			voffset = vend - vstart - size;
> +	} else
> +		voffset = 0;
> +
>  	/*
>  	 * If an allocation fails, the "vend" address is
>  	 * returned. Therefore trigger the overflow path.
>  	 */
> -	addr = __alloc_vmap_area(size, align, vstart, vend);
> +	addr = __alloc_vmap_area(size, align, vstart + voffset, vend);
>  	spin_unlock(&free_vmap_area_lock);

What if there isn't any free address space between vstart+voffset and
vend, but there is free address space between vstart and voffset?
Seems like we should add:

	addr = __alloc_vmap_area(size, align, vstart + voffset, vend);
+	if (!addr)
+		addr = __alloc_vmap_area(size, align, vstart, vend);
	spin_unlock(&free_vmap_area_lock);
