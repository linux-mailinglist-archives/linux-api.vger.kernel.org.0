Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41EA47271C7
	for <lists+linux-api@lfdr.de>; Thu,  8 Jun 2023 00:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjFGWdH (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 7 Jun 2023 18:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbjFGWdE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 7 Jun 2023 18:33:04 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DC1199D
        for <linux-api@vger.kernel.org>; Wed,  7 Jun 2023 15:33:01 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-75d13719304so659888785a.3
        for <linux-api@vger.kernel.org>; Wed, 07 Jun 2023 15:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1686177180; x=1688769180;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8llCPG+vVtkPUwjQtiWJ3WQx6JiHNRGSvHVuzeIpYl8=;
        b=Teys5iOPggBuB4MwMYC4fYT40I07CnWHKp2KVP33MNp7LzhrMhIh6ZjObVDrpqopU6
         S65i4AlM1ZRe6MI3inCaIuujJqtHY3mpfIHpgYcW3A2moxi69m94sezvmvs3B/NcLx+7
         iU+VVrAlgQt2E7JKi5S6PiaNiVlghFzKR/ARm11fVjxDlhrC+EKlyw5njk6unuVZY8MW
         EqRLzYpdwLrMOAVx5/6LqgWGEftbBGDSRQ73BGXA1yS4lh7PHIgetQguKtqN2iwwYQrl
         rwvddBBAltGZgnSQjwVhbs9jpRJ5MjhJTCZCQ/GMvIcTgN17Ae8n/+YiEOm36PPooY7e
         LhRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686177180; x=1688769180;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8llCPG+vVtkPUwjQtiWJ3WQx6JiHNRGSvHVuzeIpYl8=;
        b=dcmYpGDqd5hPk9feQhigvz6M+QmPUjIiAbyxcyv1p3/ZEvMslKdU17bFxG/bbg0YMG
         Zsa52+jLRIWMR2iO7HZjHEwnhrkmUoJmhHEuvw1lEMQKGl7eLcK8YPwSoKXRCnKzzSha
         s1q/xm+3pOsyzfr7Ymqbpm3KkUHceBxaLkbHzzvRG7yUPTH83X2TSO+Ei5v8l42ArLNZ
         Yf6le8/yNc1n9sgLqVOLJUv//u7Upx+olvi/5h3KfJ2nVZBskIKy6YpLQeN8MXsIJhxA
         a+dbxwQ+JlhIMttJvzCRhh4uQCvY54szC++Sc92AnU7PMYDIYBGTTIo74vPbqEeJlpco
         WXUg==
X-Gm-Message-State: AC+VfDwtgezUqxRDCNj7gMcZLr3X5bQPnHr0q6H2FyOHOqoDsgaL91uc
        2ihKt2nXmuTfXE44pN5FOLq0
X-Google-Smtp-Source: ACHHUZ6HuJH98YyEK9wHunJsZWtU8xAgmefz01BAYcD2rGExrmEEa1OcsJqKl5/Lpuv7iYuO62ZykQ==
X-Received: by 2002:ac8:7f81:0:b0:3f8:6cc0:d663 with SMTP id z1-20020ac87f81000000b003f86cc0d663mr5296197qtj.17.1686177180421;
        Wed, 07 Jun 2023 15:33:00 -0700 (PDT)
Received: from localhost (static-96-237-115-254.bstnma.fios.verizon.net. [96.237.115.254])
        by smtp.gmail.com with ESMTPSA id g4-20020ac80704000000b003ef33e02eb9sm230021qth.83.2023.06.07.15.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 15:33:00 -0700 (PDT)
Date:   Wed, 07 Jun 2023 18:32:59 -0400
Message-ID: <b09b591926e0f297fe0a3e9d8fcf3a6a.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net, selinux@vger.kernel.org
Subject: Re: [PATCH v10 10/11] SELinux: Add selfattr hooks
References: <20230428203417.159874-11-casey@schaufler-ca.com>
In-Reply-To: <20230428203417.159874-11-casey@schaufler-ca.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Apr 28, 2023 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Add hooks for setselfattr and getselfattr. These hooks are not very
> different from their setprocattr and getprocattr equivalents, and
> much of the code is shared.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Cc: selinux@vger.kernel.org
> Cc: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/hooks.c | 154 +++++++++++++++++++++++++++++++--------
>  1 file changed, 124 insertions(+), 30 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 2ee92d3fb79d..e78b955e04f8 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6542,6 +6559,81 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
>  	return error;
>  }
>  
> +static int selinux_getselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
> +			       size_t *size, u32 flags)
> +{
> +	char *value;
> +	size_t total_len;
> +	int len;
> +	int rc;
> +
> +	len = selinux_lsm_getattr(attr, current, &value);
> +	if (len < 0)
> +		return len;
> +
> +	total_len = ALIGN(struct_size(ctx, ctx, len), 8);
> +
> +	if (total_len > *size)
> +		rc = -E2BIG;

Hmm.  Since we need to calculate the aligned @total_len value in the
LSM specific code, perhaps it doesn't make sense to also do the
alignment in lsm_fill_user_ctx().  My apologies, I know I was the one
who suggested doing the alignment in a common place previously.

> +	else if (ctx)
> +		rc = lsm_fill_user_ctx(ctx, value, len, LSM_ID_SELINUX, 0);
> +	else
> +		rc = 1;
> +
> +	*size = total_len;
> +	if (rc < 0)
> +		return rc;
> +	return 1;
> +}

--
paul-moore.com
