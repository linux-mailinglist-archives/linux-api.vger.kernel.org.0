Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89EE316F43
	for <lists+linux-api@lfdr.de>; Wed, 10 Feb 2021 19:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbhBJSxq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 10 Feb 2021 13:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234329AbhBJSvw (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 10 Feb 2021 13:51:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAEAC061788;
        Wed, 10 Feb 2021 10:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EjxwxHUNaOq23km6417evCVsqogE3nHC3sVFoKbPKg8=; b=cbatPENJ45p15QeKsGBV3IHWYB
        MYY+XRAjvFdyEP+iDEN7xkSzpBF8JaSpuGwjfgDQQEVoM/xpsvi3INdXoOuJZl4r0QQlnvHCCAciJ
        K/i0cA3Pwgde9FWWOLhdkA6YYagUEcEIMGbqk7+KZOOQ+qxq6cOSsGyLEBBVqyg8IR/EhcXGSzAi5
        DrmHQ7abaKogcEgwxl2IxF8lApwCsy2ypMG647U37oOag2em5SznPVPpv05MjbAzva3gYU3woa/oH
        +xIIvR6HMXdLr+peIu0bMCI/atrUkCcGpsugia1PXfoSpgp6DYOk2ID3l6Da2Zgsc8BsE+tykWGjN
        kz8+SQ8Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l9uZg-009FhE-Fm; Wed, 10 Feb 2021 18:50:53 +0000
Date:   Wed, 10 Feb 2021 18:50:52 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Zhou Wang <wangzhou1@hisilicon.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-api@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        song.bao.hua@hisilicon.com, jgg@ziepe.ca, kevin.tian@intel.com,
        jean-philippe@linaro.org, eric.auger@redhat.com,
        liguozhu@hisilicon.com, zhangfei.gao@linaro.org,
        Sihang Chen <chensihang1@hisilicon.com>
Subject: Re: [RFC PATCH v3 1/2] mempinfd: Add new syscall to provide memory
 pin
Message-ID: <20210210185052.GE308988@casper.infradead.org>
References: <1612685884-19514-2-git-send-email-wangzhou1@hisilicon.com>
 <ED58431F-5972-47D1-BF50-93A20AD86C46@amacapital.net>
 <2e6cf99f-beb6-9bef-1316-5e58fb0aa86e@hisilicon.com>
 <YCJX6QFQ4hsNRrFj@kroah.com>
 <f73951ba-84be-b7f8-8c79-db84bc9081f3@hisilicon.com>
 <YCJ5k/Bxxkg3BNNj@kroah.com>
 <2237506a-0c98-7ba6-5d5f-b60b637174c5@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2237506a-0c98-7ba6-5d5f-b60b637174c5@hisilicon.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Feb 09, 2021 at 08:20:18PM +0800, Zhou Wang wrote:
> Agree, will add it in next version.

No, don't do another version.  Jason is right, this approach is wrong.
The point of SVA is that it doesn't require the application to do
anything special.  If jitter from too-frequent page migration is actually
a problem, then fix the frequency of page migration.  Don't pretend that
this particular application is so important that it prevents the kernel
from doing its housekeeping.
