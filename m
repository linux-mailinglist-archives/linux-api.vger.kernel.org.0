Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06E633E3901
	for <lists+linux-api@lfdr.de>; Sun,  8 Aug 2021 07:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbhHHFYk (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 8 Aug 2021 01:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhHHFYj (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 8 Aug 2021 01:24:39 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC26AC061760
        for <linux-api@vger.kernel.org>; Sat,  7 Aug 2021 22:24:19 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id u16so12897464ple.2
        for <linux-api@vger.kernel.org>; Sat, 07 Aug 2021 22:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=weUprCBwFfjQMVJBJInA1XbVDuOO3h8lvwnjNPGt2dg=;
        b=Vb3VoFQAJS0bxS60ApFK3/BSX9xoP+Ysai6D3/Leot03CmnsF9XBQ+Bn/3e47o/E/R
         IcQfet52sS+AomzAZ/qZ2kHgE/dajxH6TCtGf7l7if/nvBeN7rvXXQdYfyRdTpKHtLbb
         p1ZhktFsPG9pC0UMGV+QIvxQS3QwSeVKOIxOmtfqmw3c/FQkhwsXIdPJXbtRSZrGBT6/
         OdSvv//LUl/c5/m7Sru22v+gdhMmrc5IIg26mqr4oPvXjYNKGfw/YkG8mSX3Ucvf6GvD
         SQNsH+6pui4+vgseDVLi8po2PzwX5EQ6X+Ix3zeodSXjPnqX7yC5jcScspMo85L3n+vC
         Fwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=weUprCBwFfjQMVJBJInA1XbVDuOO3h8lvwnjNPGt2dg=;
        b=b/u7Or0+B2JU8ztGqNxfa3hL36QtiGnXjZu4Hdj8w+KtTmdYWJAh9JF2WlgL6T3E9A
         W1y+RsFY41UgbEfjLG/bDqC2CKJtOPj9o5EvMw3mufEBhxnWVAjsPuPbrzzedcYMQA0/
         +t1TI7V3jNTqNh0yPhHU+tezcVOVkgPN9x/abHDJ9zvhBxIRuVxECP0OTX536hSPXUHT
         +jlfS5LJif3jyDX/Lh52DU7gQ9u0SLHv7g6cBjgJvfkkV2FMssRMD2W45Qz9+CVY9iPD
         ftAsMiwoF6zd0Ac2GOMC0Gq9gTLALwSsYNvLkvpU3BMP41FxxeFBv+odRoMpH1pu6e9/
         6wSw==
X-Gm-Message-State: AOAM5326z1PZB1ERiWSw3QvhBncllT0f5T9zPxSn40cfA5dxf/44r7em
        860fvcYZnEQb3PCZQ8NOK0ylzw==
X-Google-Smtp-Source: ABdhPJxK7p1TPtwlzB9vGYb8EY70gMf0cFDzWZ35S6ZPStSq2r0UYglJS/KNqLvMF0C7wl2Kyz9PZQ==
X-Received: by 2002:a17:90a:5515:: with SMTP id b21mr6962572pji.142.1628400259117;
        Sat, 07 Aug 2021 22:24:19 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:c29e:146d:490d:33cc])
        by smtp.gmail.com with ESMTPSA id k6sm18912307pgk.1.2021.08.07.22.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 22:24:18 -0700 (PDT)
Date:   Sun, 8 Aug 2021 15:23:59 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     jack@suse.cz, amir73il@gmail.com, christian.brauner@ubuntu.com
Cc:     linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH v4 0/5] Add pidfd support to the fanotify API
Message-ID: <cover.1628398044.git.repnop@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hey Jan/Amir,

This is V5 of the FAN_REPORT_PIDFD patch series. It contains the minor
comment/commit description fixes that were picked up by Amir in the
last series review [0, 1].

LTP tests for this API change can be found here [2]. Man page updates
for this change can be found here [3].

[0] https://lore.kernel.org/linux-fsdevel/CAOQ4uxhnCk+FXK_e_GA=jC_0HWO+3ZdwHSi=zCa2Kpb0NDxBSg@mail.gmail.com/
[1] https://lore.kernel.org/linux-fsdevel/CAOQ4uxgO3oViTSFZ0zs6brrHrmw362r1C9SQ7g6=XgRwyrzMuw@mail.gmail.com/
[2] https://github.com/matthewbobrowski/ltp/tree/fanotify_pidfd_v2
[3] https://github.com/matthewbobrowski/man-pages/tree/fanotify_pidfd_v1

Matthew Bobrowski (5):
  kernel/pid.c: remove static qualifier from pidfd_create()
  kernel/pid.c: implement additional checks upon pidfd_create()
    parameters
  fanotify: minor cosmetic adjustments to fid labels
  fanotify: introduce a generic info record copying helper
  fanotify: add pidfd support to the fanotify API

 fs/notify/fanotify/fanotify_user.c | 251 ++++++++++++++++++++---------
 include/linux/fanotify.h           |   3 +
 include/linux/pid.h                |   1 +
 include/uapi/linux/fanotify.h      |  13 ++
 kernel/pid.c                       |  15 +-
 5 files changed, 204 insertions(+), 79 deletions(-)

-- 
2.32.0.605.g8dce9f2422-goog

/M
