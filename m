Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B4C247C5B
	for <lists+linux-api@lfdr.de>; Tue, 18 Aug 2020 05:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgHRDAh (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 17 Aug 2020 23:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbgHRDAh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 17 Aug 2020 23:00:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4F0C061389;
        Mon, 17 Aug 2020 20:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=H/DbB7pBbgOn0Q7tg6eRhr3Ei+qntcmROPbAJdmUrhw=; b=u87PHldgMoutph7ROXXKPW6Net
        IP4fTTbxnyRR07BhgV6D3YRSO/IxkIO5LkD6I4FuhQ581WaJ9FrcOecpYLCD0UBfjwAJqEi5Q9lRS
        wNPULqtX27dSr7bHCPBVSwo0G6X1E6TKDENC9lcO+dTtPz9IMZSjb8rv5k5wFPBejOuNUoXTJltIH
        ug4hv7XNR529sEK0m146F+kViawZ9VJ66neSUMc9ZO6NhUracFmiQN754uqopJvZbYyVUN33sA3bN
        mGynXKFAflNHpcZHyyw4IOwKmS07Ac8Oyrg0XWsqymRvXNH9IRWxcanOXTrZBhDI18XY0dJFxrcMR
        dMnlTKYA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k7rrJ-0000A0-4D; Tue, 18 Aug 2020 03:00:21 +0000
Date:   Tue, 18 Aug 2020 04:00:21 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Peter Collingbourne <pcc@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mm@kvack.org, kernel test robot <lkp@intel.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v3] mm: introduce reference pages
Message-ID: <20200818030021.GM17456@casper.infradead.org>
References: <20200814213310.42170-1-pcc@google.com>
 <c2f7efa7-0b52-b92f-79bc-a0cc26b0d92c@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2f7efa7-0b52-b92f-79bc-a0cc26b0d92c@nvidia.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Aug 17, 2020 at 07:31:39PM -0700, John Hubbard wrote:
> >            Real time (s)    Max RSS (KiB)
> > anon        2.237081         107088
> > memset      2.252241         112180
> > refpage     2.243786         107128
> > 
> > We can see that RSS for refpage is almost the same as anon, and real
> > time overhead is 44% that of memset.
> > 
> 
> Are some of the numbers stale, maybe? Try as I might, I cannot combine
> anything above to come up with 44%. :)

You're not trying hard enough ;-)

(2.252241 - 2.237081) / 2.237081 = .00677668801442594166
(2.243786 - 2.237081) / 2.237081 = .00299720930981041812
.00299720930981041812 / .00677668801442594166 = .44228232189973614648

tadaa!

As I said last time this was posted, I'm just not excited by this.  We go
from having a 0.68% time overhead down to an 0.30% overhead, which just
doesn't move the needle for me.  Maybe there's a better benchmark than
this to show benefits from this patchset.

