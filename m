Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122706EB225
	for <lists+linux-api@lfdr.de>; Fri, 21 Apr 2023 21:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbjDUTPX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 Apr 2023 15:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbjDUTPJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 Apr 2023 15:15:09 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3D249E0
        for <linux-api@vger.kernel.org>; Fri, 21 Apr 2023 12:14:38 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-63d4595d60fso16361716b3a.0
        for <linux-api@vger.kernel.org>; Fri, 21 Apr 2023 12:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682104478; x=1684696478;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jEgvnbrmc3TuMJvfDzFRQ8r7bac/zec/QDnNR+fUu8o=;
        b=XaoLIVvhAeXIoGslsijhHTqvr5OalUonOX+tyIs6Ddonyz6IfPbZONBCCPmwbOnIal
         +48DAhCUPm2K5TjUujQxz0rWUwr9B9Ln+ubWLI5Yq5o5+7yyaPX6w7Dx1youqzZpcpEn
         tjtdehYOl/YFN6y8LIVKV7KUt5Op3re6w+ojw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682104478; x=1684696478;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jEgvnbrmc3TuMJvfDzFRQ8r7bac/zec/QDnNR+fUu8o=;
        b=NVv+l1YbRF/P4aSZAv7Hl4Z7e2ava7C2vuPCkJneXMhO6PV/RFXFUe+VxNtZO/8vvG
         oJMnXqFTL0Y2uGY79+GjLg6xFQDq7d3LyrS3Z35ve3Ns4h0ngeL2e9A193/0pVjRGQyj
         crOE22kZSvsYizBOOCJb8bdCnUMopdSJFFznEQthar7jF9FnrJTx9vLqgLerA8a+/cHf
         lrYzAKKZMZ6DFN45XWLBI1kknY5AybKHWWEXkyWLoyIJCGxX4i/1CdqM0Qw373/MG5md
         1sqYi5S6/lyOS6uviE0yglWBBC2g7/iM1QyKvoqdlMtQdVa3SI80tAwZyTtv7OyMLtBb
         DwFg==
X-Gm-Message-State: AAQBX9fjVPbhYGP9yIVfQRtmLRR5nxUhNFdSnx0o/CufcDRefWvSvuRb
        fgUDXktlusKklKDtHRNSQMhzlA==
X-Google-Smtp-Source: AKy350Y1f+YAGYXv9LimfavyX8lKVpE9VjmW53qYwi1ozA+66yPdlwNXJo3fUaJrly4Ejdz2PSnCZw==
X-Received: by 2002:a17:903:24f:b0:1a6:4032:ef2 with SMTP id j15-20020a170903024f00b001a640320ef2mr6485460plh.28.1682104477975;
        Fri, 21 Apr 2023 12:14:37 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e9-20020a170902744900b001a656784229sm3039333plt.211.2023.04.21.12.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 12:14:37 -0700 (PDT)
Message-ID: <6442e09d.170a0220.86574.6e1e@mx.google.com>
X-Google-Original-Message-ID: <202304211210.@keescook>
Date:   Fri, 21 Apr 2023 12:14:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     paul@paul-moore.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net
Subject: Re: [PATCH v9 01/11] LSM: Identify modules by more than name
References: <20230421174259.2458-1-casey@schaufler-ca.com>
 <20230421174259.2458-2-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421174259.2458-2-casey@schaufler-ca.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Apr 21, 2023 at 10:42:49AM -0700, Casey Schaufler wrote:
> Create a struct lsm_id to contain identifying information
> about Linux Security Modules (LSMs). At inception this contains
> the name of the module, an identifier associated with the security
> module and an integer member "attrs" which identifies the API
> related data associated with each security module. The initial set
> of features maps to information that has traditionaly been available
> in /proc/self/attr. They are documented in a new userspace-api file.
> Change the security_add_hooks() interface to use this structure.
> Change the individual modules to maintain their own struct lsm_id
> and pass it to security_add_hooks().
> 
> The values are for LSM identifiers are defined in a new UAPI
> header file linux/lsm.h. Each existing LSM has been updated to
> include it's LSMID in the lsm_id.
> 
> The LSM ID values are sequential, with the oldest module
> LSM_ID_CAPABILITY being the lowest value and the existing modules
> numbered in the order they were included in the main line kernel.
> This is an arbitrary convention for assigning the values, but
> none better presents itself. The value 0 is defined as being invalid.
> The values 1-99 are reserved for any special case uses which may
> arise in the future. This may include attributes of the LSM
> infrastructure itself, possibly related to namespacing or network
> attribute management. A special range is identified for such attributes
> to help reduce confusion for developers unfamiliar with LSMs.
> 
> LSM attribute values are defined for the attributes presented by
> modules that are available today. As with the LSM IDs, The value 0
> is defined as being invalid. The values 1-99 are reserved for any
> special case uses which may arise in the future.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Cc: linux-security-module <linux-security-module@vger.kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

Some nit-picks below...

> [...]
> +/**
> + * struct lsm_id - Identify a Linux Security Module.
> + * @lsm: name of the LSM, must be approved by the LSM maintainers
> + * @id: LSM ID number from uapi/linux/lsm.h
> + *
> + * Contains the information that identifies the LSM.
> + */
> +struct lsm_id {
> +	const u8	*lsm;

Since this is a %NUL-terminated string, I'd keep the convention of
leaving this as "char", and perhaps even const. And "name" or "lsm_name"
seems more descriptive:

	const char *const name;

> +	u64		id;

if this is "id", "name" makes sense above.

-- 
Kees Cook
