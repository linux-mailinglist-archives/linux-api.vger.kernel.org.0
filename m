Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E813E1BA71A
	for <lists+linux-api@lfdr.de>; Mon, 27 Apr 2020 16:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbgD0O6P (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 27 Apr 2020 10:58:15 -0400
Received: from verein.lst.de ([213.95.11.211]:48813 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727073AbgD0O6O (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 27 Apr 2020 10:58:14 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0820A68C7B; Mon, 27 Apr 2020 16:58:13 +0200 (CEST)
Date:   Mon, 27 Apr 2020 16:58:12 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Martijn Coenen <maco@android.com>
Cc:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com,
        narayan@google.com, zezeozue@google.com, kernel-team@android.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        maco@google.com, bvanassche@acm.org, Chaitanya.Kulkarni@wdc.com,
        jaegeuk@kernel.org, Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v3 9/9] loop: Add LOOP_SET_FD_AND_STATUS ioctl
Message-ID: <20200427145812.GI5490@lst.de>
References: <20200427074222.65369-1-maco@android.com> <20200427074222.65369-10-maco@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427074222.65369-10-maco@android.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
