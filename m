Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 082811C67ED
	for <lists+linux-api@lfdr.de>; Wed,  6 May 2020 08:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgEFGJq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 6 May 2020 02:09:46 -0400
Received: from verein.lst.de ([213.95.11.211]:39079 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726438AbgEFGJq (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 6 May 2020 02:09:46 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4601168C4E; Wed,  6 May 2020 08:09:44 +0200 (CEST)
Date:   Wed, 6 May 2020 08:09:44 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Martijn Coenen <maco@android.com>
Cc:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com,
        narayan@google.com, zezeozue@google.com, kernel-team@android.com,
        maco@google.com, bvanassche@acm.org, Chaitanya.Kulkarni@wdc.com,
        jaegeuk@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v4 10/10] loop: Add LOOP_CONFIGURE ioctl
Message-ID: <20200506060944.GG10771@lst.de>
References: <20200429140341.13294-1-maco@android.com> <20200429140341.13294-11-maco@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429140341.13294-11-maco@android.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Thanks, this looks very nice!

Reviewed-by: Christoph Hellwig <hch@lst.de>

Are you also going to submit a patch to util-linux to use the new
ioctl?
