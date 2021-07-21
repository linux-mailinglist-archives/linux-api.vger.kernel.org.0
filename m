Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13C563D08BA
	for <lists+linux-api@lfdr.de>; Wed, 21 Jul 2021 08:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233601AbhGUFhL (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 21 Jul 2021 01:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233254AbhGUFg7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 21 Jul 2021 01:36:59 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85FCC0613DB
        for <linux-api@vger.kernel.org>; Tue, 20 Jul 2021 23:17:26 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id gv20-20020a17090b11d4b0290173b9578f1cso415785pjb.0
        for <linux-api@vger.kernel.org>; Tue, 20 Jul 2021 23:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=8uCp46ImvOgWa9UyjUPDoGLTVj3tcqAJCj1XniwrNiw=;
        b=B9IlnaRBuRNB1oSr1pJNEQidkE7pZe8zqpMHRKXNd6jcCE84xR1FHOK9neFtl8W5Jx
         h7kWNJaJLNP0CClLcsXK7x3DqRD7VSsyMMQhrZX3fQV8SXGTTaebbsJs/Uv0xAILgN3D
         6Ihkf62IdEbaDRoD0pAq7OF0Z+S8qEU0iJw0dHu19U2CPE96He33msgBzM4fRDzh+xzY
         SniIS0akPTw5RvbT+ctATwAmw5EmTX9IRlaZCyHfNpVXssDwtGB7aN3Fy/bMtLHCqevI
         seeMkLttKTEKkB7YgehaPpqvssVEnCryb9SdbbfbzExP+vXOkl3d1qpNkptuPw9HcP0k
         lVNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=8uCp46ImvOgWa9UyjUPDoGLTVj3tcqAJCj1XniwrNiw=;
        b=KrxpZ4hODBw0U6TbCIh7Nbpd9EgLEm3Hi9yN3Q9zlf04cNHzuBRizYIVHeVpyFf+v3
         FW+86N9M4oUjN9ZVDJ0HcaAeEV8qpgPzCpVL4zv4Klzf3Rs+HPITr3SrbIoL3GnE7gwZ
         3hLgN+ZXEH8m6WjE00DMGqMmdMnyChYhuPjfhXmgwODf1OGLZOxGqnE/dJ9kY25cb7qw
         L7wtxHK3css9spTqZK2wC1vo1UVm6geoNsRsTHmtjPCBTdnWeMXV0A72jk5BwsL3mL54
         6NtB3AaBGFEZmJnVnJe5Vvirm5Tus7SK464jrEtCzNl6MhvOVC+BZvmetEkvfQzjqOEX
         6ddQ==
X-Gm-Message-State: AOAM532Fq/5fhbDjJe8wqy7eGU7W5mE7v2ic/XFLPdcal7o2crvpvybD
        Sr+xVzWx6i4Yxpw8nIobWReefQ==
X-Google-Smtp-Source: ABdhPJwYCRdq0WmMoZOc63NSNJYVoR/qId1AztX5GG9Kzwe/jnOzR5O7IsdEvJw3k8ol/+ciwYIXMw==
X-Received: by 2002:a17:90b:310a:: with SMTP id gc10mr33523912pjb.173.1626848246088;
        Tue, 20 Jul 2021 23:17:26 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:c03c:a42a:c97a:1b7d])
        by smtp.gmail.com with ESMTPSA id g71sm1384542pfb.139.2021.07.20.23.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 23:17:25 -0700 (PDT)
Date:   Wed, 21 Jul 2021 16:17:12 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     jack@suse.cz, amir73il@gmail.com, christian.brauner@ubuntu.com
Cc:     linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH v3 0/5] Add pidfd support to the fanotify API
Message-ID: <cover.1626845287.git.repnop@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hey Jan/Amir/Christian,

This is an updated version of the FAN_REPORT_PIDFD series which contains
the addressed nits from the previous review [0]. As per request, you can
also find the draft LTP tests here [1] and man-pages update for this new
API change here [2].

[0] https://lore.kernel.org/linux-fsdevel/cover.1623282854.git.repnop@google.com/
[1] https://github.com/matthewbobrowski/ltp/commits/fanotify_pidfd_v2
[2] https://github.com/matthewbobrowski/man-pages/commits/fanotify_pidfd_v1

Matthew Bobrowski (5):
  kernel/pid.c: remove static qualifier from pidfd_create()
  kernel/pid.c: implement additional checks upon pidfd_create()
    parameters
  fanotify/fanotify_user.c: minor cosmetic adjustments to fid labels
  fanotify/fanotify_user.c: introduce a generic info record copying
    helper
  fanotify: add pidfd support to the fanotify API

 fs/notify/fanotify/fanotify_user.c | 252 ++++++++++++++++++++---------
 include/linux/fanotify.h           |   3 +
 include/linux/pid.h                |   1 +
 include/uapi/linux/fanotify.h      |  13 ++
 kernel/pid.c                       |  15 +-
 5 files changed, 205 insertions(+), 79 deletions(-)

-- 
2.32.0.432.gabb21c7263-goog

/M
