Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2E433A3E6
	for <lists+linux-api@lfdr.de>; Sun, 14 Mar 2021 10:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235066AbhCNJbT (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 14 Mar 2021 05:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234926AbhCNJbL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 14 Mar 2021 05:31:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5710C061574;
        Sun, 14 Mar 2021 01:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SykGWp4zjmnTjLde0zD0XJaXm2zUhar4dKi1VK326yQ=; b=ZZZ/k7tHndF4lrwDLu7QsF4LCY
        SiZr7u0v8HCIZqJXK7fEq48wHWj3Fwz2zBJ5ohvlluvs69SvUeBhIDjc92RYaJcO/vknHK3xj6ZrL
        kIlYFI9Xnxy+3PiCcR4IGGVBqZsPv75RBwAQDh0oG6Gv1kA3tD+RkEoWFgm7Li2xxJIamefvttM3l
        vHlDCt9WcNFb7v97qGxtuppZx7AMmct9BYvDtDuIMnOLUK5r1QSlhdAb24PDrKCobkw52WJIhP+jR
        9u8hmOl4XU8Z0RgvKv96m7+ZZn25Y4RBz4OIz1xZC8sUhvkAKsCbPO1FenZSPOswBgTzAwD7H8dqb
        xAmendUQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lLN54-00FqvD-M3; Sun, 14 Mar 2021 09:30:45 +0000
Date:   Sun, 14 Mar 2021 09:30:38 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Mike Snitzer <snitzer@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        pavel.tide@veeam.com
Subject: Re: [PATCH v7 3/3] dm: add DM_INTERPOSED_FLAG
Message-ID: <20210314093038.GC3773360@infradead.org>
References: <1615563895-28565-1-git-send-email-sergei.shtepa@veeam.com>
 <1615563895-28565-4-git-send-email-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615563895-28565-4-git-send-email-sergei.shtepa@veeam.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Mar 12, 2021 at 06:44:55PM +0300, Sergei Shtepa wrote:
> DM_INTERPOSED_FLAG allow to create DM targets on "the fly".
> Underlying block device opens without a flag FMODE_EXCL.
> DM target receives bio from the original device via
> bdev_interposer.

This is more of a philopical comment, but the idea of just letting the
interposed reopen the device by itself seems like a bad idea.  I think
that is probably better hidden in the block layer interposer attachment
function, which could do the extra blkdev_get_by_dev for the caller.
