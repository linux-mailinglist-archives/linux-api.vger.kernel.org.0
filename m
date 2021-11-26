Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8F645F662
	for <lists+linux-api@lfdr.de>; Fri, 26 Nov 2021 22:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243934AbhKZVbw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 26 Nov 2021 16:31:52 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:54162 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237037AbhKZV3u (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 26 Nov 2021 16:29:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED9E2B82808;
        Fri, 26 Nov 2021 21:26:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49323C004E1;
        Fri, 26 Nov 2021 21:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637961994;
        bh=ZQkH4mGansjnXBo02i2YweNtoWlzieOlKca4U14fVNk=;
        h=From:To:Cc:Subject:Date:From;
        b=MwZ09k7IgJ6L2Lry0RXCndm8k0dD6y7AcsBY05RhNtRYhjUGL/iVDIMHvcf+qg7vl
         eebwDiEmjkUa7aqnsx3152FtIf9tsV4mzSntiu7gKamW5vT/5L5LpbtRUeBWFbFHxm
         cTOPWnN73B7n9GcM3Pe6nb11OjihRuDAqCEYnURWPL5BesfGaKXCGoFcObQM0hBPFp
         7mb8mzVLlJoQclX333NCTBIDFDm1ejKBufqvSanqYlgsQYUNnd4QWMJ8616dJ7jKPm
         POHoPh4zIMmeYbdfFK9MzxLr73XReYGOb0nqR07wAsWSmVwSRhQyI2rb8c21Y2/dVt
         n4ohlXIMwa9aQ==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: [PATCH 0/3] block: show crypto capabilities in sysfs
Date:   Fri, 26 Nov 2021 13:25:11 -0800
Message-Id: <20211126212514.173334-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This series adds sysfs files that expose the inline encryption
capabilities of request queues.

Patches 1 and 2 are some related cleanups for existing blk-sysfs code.
Patch 3 is the real change; see there for more details.

This applies to linux-block/for-next.

Eric Biggers (3):
  block: simplify calling convention of elv_unregister_queue()
  block: don't delete queue kobject before its children
  blk-crypto: show crypto capabilities in sysfs

 Documentation/block/queue-sysfs.rst |  30 +++++
 block/Makefile                      |   3 +-
 block/blk-crypto-internal.h         |  12 ++
 block/blk-crypto-sysfs.c            | 177 ++++++++++++++++++++++++++++
 block/blk-crypto.c                  |   3 +
 block/blk-sysfs.c                   |  17 ++-
 block/elevator.c                    |   8 +-
 include/linux/blkdev.h              |   1 +
 8 files changed, 241 insertions(+), 10 deletions(-)
 create mode 100644 block/blk-crypto-sysfs.c

base-commit: 4d162e24e9979dcb3d7825229982c172ca4bde54
-- 
2.34.1

