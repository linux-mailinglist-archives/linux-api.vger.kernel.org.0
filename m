Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCDF63A213F
	for <lists+linux-api@lfdr.de>; Thu, 10 Jun 2021 02:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbhFJAWu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 9 Jun 2021 20:22:50 -0400
Received: from mail-pl1-f169.google.com ([209.85.214.169]:39749 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhFJAWt (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 9 Jun 2021 20:22:49 -0400
Received: by mail-pl1-f169.google.com with SMTP id v11so32469ply.6
        for <linux-api@vger.kernel.org>; Wed, 09 Jun 2021 17:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=p1WSxsB6TRu9i7KJSrAgNiOR3znkSZzluTlpf7uAoYE=;
        b=JJ3fRUajeIRSVXjXqqBXtgV6MCDGGAlouzrJTW8R0tjBo10Xm/lOxUYSpY5VOcrA2d
         wwkrZ9y+sVIRv/hlKj9/0iSf7M+hFHSbnY8ToK/3vQkFhgSH1ARokXOVh+e0zADf3tQn
         Oltzsmn6lsXurUsQqVInc46emgFQkqRXE85STTq6+/9Dm9WvF5VEl61WHFyYmQDjISO8
         dq0aCA5Urp43bSo5sSBhJf/y84KzU/grCjISoIumJNf2x4D2q5ke8mxgA/rXI/KId2wU
         BNceq8mX/5vEJTwjq/AS7kGwmNyQw6yKJrz8NKXBtWyBgdmIyiM93n/Rwiu3N0Xwk3X0
         V12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=p1WSxsB6TRu9i7KJSrAgNiOR3znkSZzluTlpf7uAoYE=;
        b=oxfgIOOK/XAFQ5hubBZe5d/Z14Fng+VmRMMxL8Jq+y5UHCPFZat47FpQl5vnvy2afZ
         2GjQb+OkkXVwI92Sq8T2KnL9zHN54ETeOCPTuhiEQXGH4LubhjbrPYiholwIaX4HToIf
         AeL+Ors63nMvp31IfOuvMDUTY6a/ibZdO4UGge7DGMPOFC6V/T99miC9PJFO/Ds1ySmS
         fDd9JnZJfa7aXw5+Arn9Rogx+OM88jyTyqrYfg82/tT5xoKbJdDlPGktDSuJujA733Qg
         akRvfIOjUXSEsZxYEDqAPtDIIkO6FwVBfjq2kJeQcf46mQl5pPV0kYBTNDdmCbThlfAV
         Z8rQ==
X-Gm-Message-State: AOAM533B3aepX0XLm/umPmRULdHJTGzUYjzGKAqEasPlJFrq2lWNqOT+
        pH7/+18+ntaXi02pGdH9Wzv3Tw==
X-Google-Smtp-Source: ABdhPJyKrtRhhcX7q88JBho0nVS81cBMjAuQYbAiaool0tyllwsMQ/7sJo58KhWY97F61exNG+C5+w==
X-Received: by 2002:a17:902:f704:b029:f4:228d:4dca with SMTP id h4-20020a170902f704b02900f4228d4dcamr2199568plo.26.1623284393898;
        Wed, 09 Jun 2021 17:19:53 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:6512:d64a:3615:dcbf])
        by smtp.gmail.com with ESMTPSA id t143sm817712pgb.93.2021.06.09.17.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 17:19:53 -0700 (PDT)
Date:   Thu, 10 Jun 2021 10:19:33 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     jack@suse.cz, amir73il@gmail.com, christian.brauner@ubuntu.com
Cc:     linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH v2 0/5] Add pidfd support to the fanotify API
Message-ID: <cover.1623282854.git.repnop@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hey Jan/Amir/Christian,

Sending through v2 of the fanotify pidfd patch series. This series
contains the necessary fixes/suggestions that had come out of the
previous discussions, which can be found here [0], here [1], and here
[3].

The main difference in this series is that we perform pidfd creation a
little earlier on i.e. in copy_event_to_user() so that clean up of the
pidfd can be performed nicely in the event of an info
generation/copying error. Additionally, we introduce two errors. One
being FAN_NOPIDFD, which is supplied to the listener in the event that
a pidfd cannot be created due to early process termination. The other
being FAN_EPIDFD, which will be supplied in the event that an error
was encountered during pidfd creation.

Please let me know what you think.

[0]
https://lore.kernel.org/linux-fsdevel/48d18055deb4617d97c695a08dca77eb57309\
7e9.1621473846.git.repnop@google.com/

[1]
https://lore.kernel.org/linux-fsdevel/24c761bd0bd1618c911a392d0c310c24da7d8\
941.1621473846.git.repnop@google.com/

[2]
https://lore.kernel.org/linux-fsdevel/48d18055deb4617d97c695a08dca77eb57309\
7e9.1621473846.git.repnop@google.com/


Matthew Bobrowski (5):
  kernel/pid.c: remove static qualifier from pidfd_create()
  kernel/pid.c: implement additional checks upon pidfd_create()
    parameters
  fanotify/fanotify_user.c: minor cosmetic adjustments to fid labels
  fanotify/fanotify_user.c: introduce a generic info record copying
    helper
  fanotify: add pidfd support to the fanotify API

 fs/notify/fanotify/fanotify_user.c | 260 +++++++++++++++++++++--------
 include/linux/fanotify.h           |   3 +
 include/linux/pid.h                |   1 +
 include/uapi/linux/fanotify.h      |  13 ++
 kernel/pid.c                       |  15 +-
 5 files changed, 213 insertions(+), 79 deletions(-)

-- 
2.30.2

/M
