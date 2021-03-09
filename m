Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08711332D1D
	for <lists+linux-api@lfdr.de>; Tue,  9 Mar 2021 18:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbhCIRUc (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 9 Mar 2021 12:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbhCIRUV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 9 Mar 2021 12:20:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C27C06174A;
        Tue,  9 Mar 2021 09:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hKqQl5whCBmaWHSVBpXAHPsHwOMZKD0Kuuvea7IZx9c=; b=ZOVa5yLAv+xDhi3GToUKObjegn
        RCruCVhHBNy0GLlE5OzxBZPZii/m399pItn9FOhuHsElrHUlTkzG0dpMGP1NB4ECaHEmM3Yqj1jTB
        WZoywTHK8egpU9tF/yvLL8PD8phZjIJwvY1pdILweD013a6pzFY0uo1WmwbXHoReTOvPGwd8Mpt10
        UgoDOs2YL4DCNB+CW2IugCVine+qtpIlmUp4RmtLhYbeLMSEfPwsEytnpbP0xD51OqrmntQsnTMNC
        mNqlDP3uHYDIDsJUsjKfUG1n34H/CHKnqflsG8xxDygJNJrmLJKJG61M6VsnpaJRxOIxO3V1xBuxU
        0KhlVQUw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lJg15-000qT0-AJ; Tue, 09 Mar 2021 17:19:39 +0000
Date:   Tue, 9 Mar 2021 17:19:31 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     snitzer@redhat.com, agk@redhat.com, hare@suse.de, song@kernel.org,
        axboe@kernel.dk, dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-api@vger.kernel.org, pavel.tide@veeam.com
Subject: Re: [PATCH v6 1/4] block: add blk_mq_is_queue_frozen()
Message-ID: <20210309171931.GA201344@infradead.org>
References: <1614774618-22410-1-git-send-email-sergei.shtepa@veeam.com>
 <1614774618-22410-2-git-send-email-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614774618-22410-2-git-send-email-sergei.shtepa@veeam.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Mar 03, 2021 at 03:30:15PM +0300, Sergei Shtepa wrote:
> +bool blk_mq_is_queue_frozen(struct request_queue *q)
> +{
> +	bool ret;
> +
> +	mutex_lock(&q->mq_freeze_lock);
> +	ret = percpu_ref_is_dying(&q->q_usage_counter) && percpu_ref_is_zero(&q->q_usage_counter);

Please avoid the overly long line.

Also maybe frozen is a better name for the variable currently called
ret?
