Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 483DF33B217
	for <lists+linux-api@lfdr.de>; Mon, 15 Mar 2021 13:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhCOMGX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 15 Mar 2021 08:06:23 -0400
Received: from mx4.veeam.com ([104.41.138.86]:50584 "EHLO mx4.veeam.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230169AbhCOMGX (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 15 Mar 2021 08:06:23 -0400
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.0.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.veeam.com (Postfix) with ESMTPS id 32402171E;
        Mon, 15 Mar 2021 15:06:18 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com; s=mx4;
        t=1615809978; bh=mVn36BTSzFhaZLEUHYffL8xe3v6UOYz/YXSHVjys07s=;
        h=Date:From:To:CC:Subject:References:In-Reply-To:From;
        b=gFh+ULS+jNH0u4XnkuWd8sf+8rvbY99vFfRjjm4mDEf6PHHBD3hbXQdcJTXrWousR
         kvi9VzOitKCEQcZacJvCpfiUJC65HMpxP2Rqln8k33a+IdaAGwD5jnjfs0Yajxl/87
         VqqUvn6sP+9xGhzKK9yp89S4zV2dW0RQ71xl/o6o=
Received: from veeam.com (172.24.14.5) by prgmbx01.amust.local (172.24.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2; Mon, 15 Mar 2021
 13:06:16 +0100
Date:   Mon, 15 Mar 2021 15:06:08 +0300
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Mike Snitzer <snitzer@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Pavel Tide <Pavel.TIde@veeam.com>
Subject: Re: [PATCH v7 1/3] block: add blk_mq_is_queue_frozen()
Message-ID: <20210315120608.GA30489@veeam.com>
References: <1615563895-28565-1-git-send-email-sergei.shtepa@veeam.com>
 <1615563895-28565-2-git-send-email-sergei.shtepa@veeam.com>
 <20210312190641.GA2550@redhat.com>
 <20210314091441.GA3773360@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20210314091441.GA3773360@infradead.org>
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: prgmbx01.amust.local (172.24.0.171) To prgmbx01.amust.local
 (172.24.0.171)
X-EsetResult: clean, is OK
X-EsetId: 37303A29D2A50B58627C62
X-Veeam-MMEX: True
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The 03/14/2021 12:14, Christoph Hellwig wrote:
> On Fri, Mar 12, 2021 at 02:06:41PM -0500, Mike Snitzer wrote:
> > This is returning a frozen state that is immediately stale.  I don't
> > think any code calling this is providing the guarantees you think it
> > does due to the racey nature of this state once the mutex is dropped.
> 
> The code only uses it for asserts in the form of WARN_ONs.

But perhaps it is possible to come up with a more elegant solution?
I'll think about it.
-- 
Sergei Shtepa
Veeam Software developer.
