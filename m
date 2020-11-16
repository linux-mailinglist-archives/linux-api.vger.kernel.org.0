Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC072B556E
	for <lists+linux-api@lfdr.de>; Tue, 17 Nov 2020 00:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgKPX54 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 16 Nov 2020 18:57:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:53816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727897AbgKPX54 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 16 Nov 2020 18:57:56 -0500
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BE632463F
        for <linux-api@vger.kernel.org>; Mon, 16 Nov 2020 23:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605571076;
        bh=K1kBy8UqtPsZEsO6dvQIPJFRO7gq+ki9zqGmITQP66I=;
        h=From:Date:Subject:To:From;
        b=uKQo2d1lDr3sWjXbhltT47Vwjd00H/a5GTzFGtou5w3TCleaD1ZnVhggikXtOhXIz
         cUFPOE7GR7ne9Cci4JIgdHo9p5xON3Soyb7TB/iBQE2U5QgwsbyWST20HGlsWv7haB
         /bvy31DxehoK0i/nxeFk3287/uhhZr8BqUAgPSCs=
Received: by mail-wr1-f42.google.com with SMTP id j7so20937858wrp.3
        for <linux-api@vger.kernel.org>; Mon, 16 Nov 2020 15:57:55 -0800 (PST)
X-Gm-Message-State: AOAM530C9LCmdCJ2EtOvsH/kAV2rpR034WGSnSgEcIHrilpxtLTXimoj
        49AtllM9QhQhdgOR4K+jXRKEkd3i9VtS/k/+wzjeeA==
X-Google-Smtp-Source: ABdhPJy9vsmaoiE14xhL+dOh+l2Sot3ZBd90w2CyyFU1HHZ5KhlOqtZtkwOUbx1Y9rpRkg/slRWmtr/1E3knXtLbN0Y=
X-Received: by 2002:a5d:4991:: with SMTP id r17mr22269768wrq.70.1605571074638;
 Mon, 16 Nov 2020 15:57:54 -0800 (PST)
MIME-Version: 1.0
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 16 Nov 2020 15:57:40 -0800
X-Gmail-Original-Message-ID: <CALCETrXU2KcH0nsH_vd-fmvpZt_yW2+=VnYtN_BQJ6xsSvm+6A@mail.gmail.com>
Message-ID: <CALCETrXU2KcH0nsH_vd-fmvpZt_yW2+=VnYtN_BQJ6xsSvm+6A@mail.gmail.com>
Subject: Is adding an argument to an existing syscall okay?
To:     Linux API <linux-api@vger.kernel.org>,
        Peter Oskolkov <posk@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Linux 5.10 contains this patch:

commit 2a36ab717e8fe678d98f81c14a0b124712719840
Author: Peter Oskolkov <posk@google.com>
Date:   Wed Sep 23 16:36:16 2020 -0700

    rseq/membarrier: Add MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ

This adds an argument to an existing syscall.  Before the patch,
membarrier had 2 parameters; now it has 3.  Is this really okay?  At
least the patch is careful and ignores the third parameter unless a
previously unused flag bit is set.

--Andy
