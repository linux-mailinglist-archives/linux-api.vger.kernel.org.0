Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3C3796D95
	for <lists+linux-api@lfdr.de>; Thu,  7 Sep 2023 01:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244738AbjIFXXF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 6 Sep 2023 19:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239783AbjIFXXE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 6 Sep 2023 19:23:04 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206151BC5
        for <linux-api@vger.kernel.org>; Wed,  6 Sep 2023 16:23:00 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-76ef8b91a72so24801985a.0
        for <linux-api@vger.kernel.org>; Wed, 06 Sep 2023 16:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1694042579; x=1694647379; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KOVYO4KGfJmlJ7Sc2gzc02HVhijlhI6QaYPVbI8wZaQ=;
        b=Dxi2BeWdgwdIN8YZhjupYJe/oWDTT76PYFQC1skLho99k/wqgdrDdpW4UuT7tBVGqF
         3gbmT1yv1ThDX8MkchXUN15JrBcabAO6TlxCgpIXZHzFP3JW7j7brwbDRVQekOLGiWtD
         2jP8mVX6ed3qVhC7QYNj1mI3fLwg5JRvkJTxGtDNCMPq3XPGXkTGl0sgLnosiI9OyPJZ
         gQl1LhsCN2pFATvZTcRfVDd/1/6Cpk6rkaW1GD6JLE68b47g6cwgkDC4+9c/NdI0igKo
         HjQr8FOnXoEGM0VpqrbL/Mfp4u9bFNx7A7yAa1BHdEZDOU/M1ad8c2BOBKM+hJ4KIeDC
         jrEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694042579; x=1694647379;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KOVYO4KGfJmlJ7Sc2gzc02HVhijlhI6QaYPVbI8wZaQ=;
        b=h11502Wx9zIOOAPzNJaPI7TRqFy/PEycI+2iMzfQVMmU7vilwTNG/1Pcrn39/5WpBa
         iTZeQ7loH3oWQycB39PgN+vGCauKcqu+Q4xeQFW608EoeFUSoS/jI0pcDiEvv0lYt9x7
         Si2E64uHqG9ZiQjd+J2lZ83ML0sIA7VnyORt/t3rEkRcS7ydrBciTobxhYGppF9+kLCK
         9uePlCcG56h9j/33BGzWP55DR31i+KoPXBx+Mlj0DKDa2+uUZL+PzLyx6PGDkjw5fMHa
         InL6pa7UPTB0l2hGZxFOEkiWkL+X/qa3/8RJ0oZJqI3S25weIRXC5zocZe1zWhlo89LM
         HkCw==
X-Gm-Message-State: AOJu0YyAGadMSY7DB8J21ZRt3iNU6L2zEYsUj0HEDzvkefC+EkBRCWwl
        qHiU43TPShMoAT8ekWPwcn/z
X-Google-Smtp-Source: AGHT+IFIySrBFtfHW4VE2otNW++I6blWD0r5TQBNO/aYEvyfvC2zgOpj8M47LcEvSORebSxjhgL5Bw==
X-Received: by 2002:a05:620a:28cc:b0:76f:1d46:4a9f with SMTP id l12-20020a05620a28cc00b0076f1d464a9fmr23129313qkp.4.1694042579258;
        Wed, 06 Sep 2023 16:22:59 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id w27-20020a05620a149b00b0076ef3e6e6a4sm5326420qkj.42.2023.09.06.16.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 16:22:58 -0700 (PDT)
Date:   Wed, 06 Sep 2023 19:22:58 -0400
Message-ID: <333abafe25b35db5d770b5e459c14888.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Casey Schaufler <casey@schaufler-ca.com>, serge@hallyn.com,
        mic@digikod.net, linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v14 11/11] LSM: selftests for Linux Security Module  syscalls
References: <20230828195802.135055-12-casey@schaufler-ca.com>
In-Reply-To: <20230828195802.135055-12-casey@schaufler-ca.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PP_MIME_FAKE_ASCII_TEXT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Aug 28, 2023 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Add selftests for the three system calls supporting the LSM
> infrastructure. This set of tests is limited by the differences
> in access policy enforced by the existing security modules.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  MAINTAINERS                                   |   1 +
>  security/security.c                           |   2 +-
>  tools/testing/selftests/Makefile              |   1 +
>  tools/testing/selftests/lsm/.gitignore        |   1 +
>  tools/testing/selftests/lsm/Makefile          |  17 ++
>  tools/testing/selftests/lsm/common.c          |  89 ++++++
>  tools/testing/selftests/lsm/common.h          |  33 +++
>  tools/testing/selftests/lsm/config            |   3 +
>  .../selftests/lsm/lsm_get_self_attr_test.c    | 275 ++++++++++++++++++
>  .../selftests/lsm/lsm_list_modules_test.c     | 140 +++++++++
>  .../selftests/lsm/lsm_set_self_attr_test.c    |  74 +++++
>  11 files changed, 635 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/lsm/.gitignore
>  create mode 100644 tools/testing/selftests/lsm/Makefile
>  create mode 100644 tools/testing/selftests/lsm/common.c
>  create mode 100644 tools/testing/selftests/lsm/common.h
>  create mode 100644 tools/testing/selftests/lsm/config
>  create mode 100644 tools/testing/selftests/lsm/lsm_get_self_attr_test.c
>  create mode 100644 tools/testing/selftests/lsm/lsm_list_modules_test.c
>  create mode 100644 tools/testing/selftests/lsm/lsm_set_self_attr_test.c

Both Serge and Mickaël had comments on the previous revision of this
patch, it would be nice if they could review the current revision and
comment.

--
paul-moore.com
