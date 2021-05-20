Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 769CF389B29
	for <lists+linux-api@lfdr.de>; Thu, 20 May 2021 04:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbhETCLT (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 19 May 2021 22:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhETCLT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 19 May 2021 22:11:19 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070D5C06175F
        for <linux-api@vger.kernel.org>; Wed, 19 May 2021 19:09:57 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 6so10768447pgk.5
        for <linux-api@vger.kernel.org>; Wed, 19 May 2021 19:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=v9bT6Q3KYnsKih8Ryw2Sd9OdkVAXXqCmJdrWbZ7beKc=;
        b=jCjWszy2BzCU8LhZunNvq+Xsjbty2JLJILsy3TP6FmGIVEnlJR1wZrMZDztS2rNBHw
         K7Fe5/gs5+1C+R0ihEoN04F7A9R/58R0bfGE+7TCjKVpbL1qRUxEBfhJUOuw5qeVLJOA
         9hLY9gdkzf73hdhH8/ElKofMpkA2ssv51kjrwBdNIUEk4haWgInhI2b4Ao6hL/z1KfYg
         MV434RgaKwiTJd09UVud7qdDqp0R7HcAkm7tsJrQPbjDhtrXDOiZXsxGwxjE71/y9vbl
         QW13E7alg15Y3oN73cHgUMqzoNqg9/YcLVNVyTaCcPNwsMLkhZxoMjUwEjvGwPDB93f8
         tOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=v9bT6Q3KYnsKih8Ryw2Sd9OdkVAXXqCmJdrWbZ7beKc=;
        b=UKHBkPRqkAqab+Tn4ZYEWqueIhxEcmC7xOZ8ovIyuS7Imy7Lm/Ke2W4CuvQVEfdcl9
         1mG3yffOW7JA5r6OcawwmZwyS9A1WzW8qlTTCrewqWBJP8IAcfz3NBeM349rt0ynS0hq
         /kYbSby1sh5YHmwqYGqWQDSTTh6/Z1f6bK6ZjVx6wA3i+V47jOlF/qnR+c8Qsr/HQRsb
         5t4fjgs3mQJ7wmWvGpO7UW6yeCv0u5wD9ZGy8aIh0F7QB7AwfYjniVz4zhWZUFJ83/HY
         OVqC7VWAE7CskPM2yBdSQ4i5Rv8d4eunYiwhdUgoJQHTJji/5OfsxV2lPVKGUyEGjSF8
         RhXA==
X-Gm-Message-State: AOAM531TCegnDhGiNVTtUAenc+C3+HXLJ2h5+tB75in+Hye06mZoc8k0
        G9Gih/S1F/00xK8uRydL/7+fJg==
X-Google-Smtp-Source: ABdhPJwtKN+DU+G4XC58h+9SRI6r0teVKKx6VheVE5kkyUSjcS2+XwH5ALYLYf+tVp7pkR11CMkQ5w==
X-Received: by 2002:a63:d710:: with SMTP id d16mr2121337pgg.214.1621476597208;
        Wed, 19 May 2021 19:09:57 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:c035:b02d:975d:1161])
        by smtp.gmail.com with ESMTPSA id i8sm546261pgt.58.2021.05.19.19.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 19:09:56 -0700 (PDT)
Date:   Thu, 20 May 2021 12:09:45 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     jack@suse.cz, amir73il@gmail.com, christian.brauner@ubuntu.com
Cc:     linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 0/5] Add pidfd support to the fanotify API
Message-ID: <cover.1621473846.git.repnop@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hey Jan/Amir/Christian,

This is the updated patch series for adding pidfd support to the
fanotify API. It incorporates all the suggestions that had come out of
the initial RFC patch series [0].

The main difference with this patch series is that FAN_REPORT_PIDFD
results in an additional info record object supplied alongside the
generic event metadata object instead of overloading metadata->pid. If
any of the fid flavoured init flags are specified, then the pidfd info
record object will follow any fid info record objects.

[0] https://www.spinics.net/lists/linux-fsdevel/msg193296.html

Matthew Bobrowski (5):
  kernel/pid.c: remove static qualifier from pidfd_create()
  kernel/pid.c: implement checks on parameters passed to pidfd_create()
  fanotify_user.c: minor cosmetic adjustments to fid labels
  fanotify/fanotify_user.c: introduce a generic info record copying
    function
  fanotify: Add pidfd info record support to the fanotify API

 fs/notify/fanotify/fanotify_user.c | 216 +++++++++++++++++++----------
 include/linux/fanotify.h           |   3 +
 include/linux/pid.h                |   1 +
 include/uapi/linux/fanotify.h      |  12 ++
 kernel/pid.c                       |  15 +-
 5 files changed, 170 insertions(+), 77 deletions(-)

-- 
2.31.1.751.gd2f1c929bd-goog

/M
