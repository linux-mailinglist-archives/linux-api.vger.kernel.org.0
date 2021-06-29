Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 889083B71AD
	for <lists+linux-api@lfdr.de>; Tue, 29 Jun 2021 14:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbhF2MCZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 29 Jun 2021 08:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbhF2MCZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 29 Jun 2021 08:02:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05089C061760;
        Tue, 29 Jun 2021 04:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EfGY/OU/KHfnG+UMGD4fPTRavasXM5eyvCC2dckCs1o=; b=gG8b4uQtZu3LtHZvhjVjE6eKeh
        mb6voMJdBc4w74OLxlAHDfv0I70o3sV1NZts8Y4twxMW+k9P9mCD2EDM/cWlkiqC90vsVPJ669eWj
        lZgGikNzFyNWYCDEJPn7j5xUYpvHVLl1GoLqY6K+K0gXcf4WyEeXDEgTiszc0GMebP/iQRgVO2Ya6
        +Xe8pNph8SF7iQWHYF4FYqeSNgTF2hreghioOP4wLDtEFEfd3H1rD3C247eJ3GKqQHGYj1qdJckj5
        OdOw/3L4NLBkpohRg7QvcnEOW2aapPWv/U6EPmzh+ciVaP5dmmZvw2e/+d79gsyJt07UVkB9vrjst
        TW9OQ+dg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lyCO1-00442t-NH; Tue, 29 Jun 2021 11:58:46 +0000
Date:   Tue, 29 Jun 2021 12:58:41 +0100
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
Message-ID: <YNsK8bZ+S3VtsK9g@casper.infradead.org>
References: <20210619092002.1791322-1-pcc@google.com>
 <51c68f8f-dea1-c0c6-7cfb-28d42338ba88@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51c68f8f-dea1-c0c6-7cfb-28d42338ba88@nvidia.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Jun 29, 2021 at 12:19:22AM -0700, John Hubbard wrote:
> > +SYSCALL_DEFINE2(refpage_create, const void *__user, content, unsigned long,
> > +		flags)
> 
> From the API discussion (and using a simpler syntax to illustrate this), it
> seems like the following would be close:
> 
> enum content_type {
> 	BYTE_PATTERN,
> 	FOUR_BYTE_PATTERN,
> 	...
> 	FULL_4KB_PAGE
> };
> 
> int refpage_create(const void *__user content, enum content_type, unsigned long flags);
> 
> ...and if content_type == BYTE_PATTERN, then content is a pointer to just one byte of
> data, and so forth for the other enum values.

That seems a little more complicated and non-extensible.

int refpage_create(const void *__user content, unsigned int size,
		unsigned long flags);

