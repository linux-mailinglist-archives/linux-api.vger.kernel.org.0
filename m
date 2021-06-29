Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69F683B77C8
	for <lists+linux-api@lfdr.de>; Tue, 29 Jun 2021 20:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbhF2SZ0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 29 Jun 2021 14:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233843AbhF2SZ0 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 29 Jun 2021 14:25:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3C9C061760;
        Tue, 29 Jun 2021 11:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yOCQ+6UBtisowgUHA8CBGoCBGxGhg2drXq/FhpEnlEE=; b=MK0w50S4DgiggrXCpbhJDbu6dJ
        Cgsv1b8HgrRsfychBcJwkAe+mJ9QTecBe2KGv9XYnRAj+6Bk3OFjL8asOxRjHvTT20OeFKV6DuXbf
        lRJTLekf5IEwyp/tU21+2JFVO7cSUfk6BS0GstZlNKQ8a7Nui/QL59Ee1IOzWEW2xcdcYih+XuSZ8
        lyaaWtRJVX5QGGQzYnr8O523DKVITbZW/P7B2pyUwhGgTjpNlWFSTcebx/n3Nk0LoKy4NQ0xdeLig
        Hp8iqgeuE3KxV7lKR2phOEPXQ6aDQ3r0ZyGh1fRA+g+V5PWjIhNTJuqQaoV29a/Ec5kyFljpyxM4x
        R8o/xcgA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lyIMH-004PFo-SP; Tue, 29 Jun 2021 18:21:39 +0000
Date:   Tue, 29 Jun 2021 19:21:17 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Peter Collingbourne <pcc@google.com>,
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
Message-ID: <YNtkncx0BdhX+kse@casper.infradead.org>
References: <20210619092002.1791322-1-pcc@google.com>
 <51c68f8f-dea1-c0c6-7cfb-28d42338ba88@nvidia.com>
 <YNsK8bZ+S3VtsK9g@casper.infradead.org>
 <3c77290d-3a79-9f41-f4ba-7eda399df150@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c77290d-3a79-9f41-f4ba-7eda399df150@nvidia.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Jun 29, 2021 at 10:48:20AM -0700, John Hubbard wrote:
> On 6/29/21 4:58 AM, Matthew Wilcox wrote:
> > int refpage_create(const void *__user content, unsigned int size,
> > 		unsigned long flags);
> > 
> 
> That does seem better. The key is to have at least one more parameter.
> 
> Actually I forgot to include pattern data. In both of the approaches above,
> flags is probably used for that, but if we already know that patterns
> are being passed, then how about add a "pattern" arg? I think it's
> good to leave a little room for flexibility and future extensions:
> 
> int refpage_create(const void *__user content, unsigned int size,
> 		unsigned long pattern, unsigned long flags);

I don't get it.  'size' is the length of the pattern, and it's
pointed to by 'content'.  Why would you pass 'pattern' as well?
