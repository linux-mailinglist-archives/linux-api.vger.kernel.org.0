Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 362873B5EC0
	for <lists+linux-api@lfdr.de>; Mon, 28 Jun 2021 15:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbhF1NOd (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 28 Jun 2021 09:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbhF1NOd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 28 Jun 2021 09:14:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BEA5C061574;
        Mon, 28 Jun 2021 06:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DoOU4Ye85iqHkPCggtrUrtpKi/JT315TV3vpm+/Y/5M=; b=NIDwCLJywS5m/1hR5mnTPJw6YX
        QUTpMMJZVek78cmbuFGnRBKc9NmFD4E3bv7HNyuGKTY6bM1EmdW/dMYJUHLlLsQzCtJf+7nH3kuPJ
        0acr8oPi7TvFmmiIDhAyKjuqAnRsqBb4Fg3DIegHzRcoTPg4x/44pnC1Bf914Np5Nc3V6JTq1LHVo
        UYz1iyyu1J7o49tkc8k7I3pDjRgSdk6coI2muUKFYug1wNI4RH+Stsw/FBh9jtQJywtWXBIju/VHd
        lMC3HIFrJ/nROziYSHf9/qy1pMXjHSEJmCM87h4SH9Y+OWel1TFZ4W4xFcx8Mv5KEq9/zNj+mu7Zh
        5TG2eFBw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxr22-002zqx-NA; Mon, 28 Jun 2021 13:10:52 +0000
Date:   Mon, 28 Jun 2021 14:10:34 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Collingbourne <pcc@google.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Jann Horn <jannh@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mm@kvack.org, kernel test robot <lkp@intel.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v4] mm: introduce reference pages
Message-ID: <YNnKSkcAM05tmPta@casper.infradead.org>
References: <20210619092002.1791322-1-pcc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210619092002.1791322-1-pcc@google.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, Jun 19, 2021 at 02:20:02AM -0700, Peter Collingbourne wrote:
> +++ b/include/linux/mm.h
> @@ -32,6 +32,7 @@
>  #include <linux/sched.h>
>  #include <linux/pgtable.h>
>  #include <linux/kasan.h>
> +#include <linux/fs.h>

No.

> +++ b/include/linux/mman.h
> @@ -2,6 +2,7 @@
>  #ifndef _LINUX_MMAN_H
>  #define _LINUX_MMAN_H
>  
> +#include <linux/fs.h>

No.

