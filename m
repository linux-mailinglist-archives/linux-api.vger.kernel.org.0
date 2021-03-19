Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9E63424ED
	for <lists+linux-api@lfdr.de>; Fri, 19 Mar 2021 19:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhCSSka (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 19 Mar 2021 14:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbhCSSkW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 19 Mar 2021 14:40:22 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D584BC061763
        for <linux-api@vger.kernel.org>; Fri, 19 Mar 2021 11:40:21 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id e14so3362816plj.2
        for <linux-api@vger.kernel.org>; Fri, 19 Mar 2021 11:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=3u9mAxNEw9z6za6KFcOo+uHqgiwiwZM5DCTyyspgn/o=;
        b=Yg6m4KOAXpRmtJyRDoH2yl2CHKC+3drp9u+T3OirmqRro1Mir6CpDUGmJiH6P/z7Kv
         6KqrLz2fDgze6egHZS4RwPVSKmftmVpcaI/zzQassSY0Au1qSOniGyFwnlpaKbGukS1B
         5ia9D9yVB+s3iHhoKPejUMLE1dxUY8uW3AgWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3u9mAxNEw9z6za6KFcOo+uHqgiwiwZM5DCTyyspgn/o=;
        b=CEIwBDNHDlAx5pr5+zV/JQZcIdQLJ6/3aGPWz6ThSA9yqhf4+Q0x6NFf0/FO9/xJdw
         suQBIasG4oJbEsroa1TbmNzx4RgWtp95t2Yer1jNTXRTe/xQtcgAeuGTC12HVmAu7gWC
         fi+VolEF4Gzaenh7GX73zmhZ7aRaJaM8QI4HkhToMEjRCCpn+ooIn6wOcWIUQLqBpnOp
         mDNwNWcf+7kCA8XzXJ7vi9vWgwkSgOVUPtSeaRC8S3oqBjh339UFE9R7R1o4/mybfxHI
         LOocGtdBcrHXDADcRa5vw66Py7adHGx7GCvTR4huoObpdg4AOBB87Za8EIwlWPGdSVD4
         frMg==
X-Gm-Message-State: AOAM532zm1mfZu50w9bEIusZMeWh9eYIU6UzbrJKKNSzyHh+kcT8OiWV
        iTLi2tVHTJlEVr7sx9mtIUpu2g==
X-Google-Smtp-Source: ABdhPJw6vg1JHhR2dRDHudF/k8t7iI2PJ2EYrpqaNdHYFuKnjDOkJMrYPpYmCpqtqBVqRL+QAvirUw==
X-Received: by 2002:a17:902:ea0e:b029:e4:81d4:ddae with SMTP id s14-20020a170902ea0eb02900e481d4ddaemr15830817plg.12.1616179221292;
        Fri, 19 Mar 2021 11:40:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i62sm6034208pgc.11.2021.03.19.11.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 11:40:20 -0700 (PDT)
Date:   Fri, 19 Mar 2021 11:40:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>
Subject: Re: [PATCH v30 02/12] landlock: Add ruleset and domain management
Message-ID: <202103191114.C87C5E2B69@keescook>
References: <20210316204252.427806-1-mic@digikod.net>
 <20210316204252.427806-3-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210316204252.427806-3-mic@digikod.net>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Mar 16, 2021 at 09:42:42PM +0100, Micka�l Sala�n wrote:
> From: Micka�l Sala�n <mic@linux.microsoft.com>
> 
> A Landlock ruleset is mainly a red-black tree with Landlock rules as
> nodes.  This enables quick update and lookup to match a requested
> access, e.g. to a file.  A ruleset is usable through a dedicated file
> descriptor (cf. following commit implementing syscalls) which enables a
> process to create and populate a ruleset with new rules.
> 
> A domain is a ruleset tied to a set of processes.  This group of rules
> defines the security policy enforced on these processes and their future
> children.  A domain can transition to a new domain which is the
> intersection of all its constraints and those of a ruleset provided by
> the current process.  This modification only impact the current process.
> This means that a process can only gain more constraints (i.e. lose
> accesses) over time.
> 
> Cc: James Morris <jmorris@namei.org>
> Cc: Jann Horn <jannh@google.com>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Micka�l Sala�n <mic@linux.microsoft.com>
> Acked-by: Serge Hallyn <serge@hallyn.com>
> Link: https://lore.kernel.org/r/20210316204252.427806-3-mic@digikod.net

(Aside: you appear to be self-adding your Link: tags -- AIUI, this is
normally done by whoever pulls your series. I've only seen Link: tags
added when needing to refer to something else not included in the
series.)

> [...]
> +static void put_rule(struct landlock_rule *const rule)
> +{
> +	might_sleep();
> +	if (!rule)
> +		return;
> +	landlock_put_object(rule->object);
> +	kfree(rule);
> +}

I'd expect this to be named "release" rather than "put" since it doesn't
do any lifetime reference counting.

> +static void build_check_ruleset(void)
> +{
> +	const struct landlock_ruleset ruleset = {
> +		.num_rules = ~0,
> +		.num_layers = ~0,
> +	};
> +
> +	BUILD_BUG_ON(ruleset.num_rules < LANDLOCK_MAX_NUM_RULES);
> +	BUILD_BUG_ON(ruleset.num_layers < LANDLOCK_MAX_NUM_LAYERS);
> +}

This is checking that the largest possible stored value is correctly
within the LANDLOCK_MAX_* macro value?

> [...]

The locking all looks right, and given your test coverage and syzkaller
work, it's hard for me to think of ways to prove it out any better. :)

Reviewed-by: Kees Cook <keescook@chromium.org>


-- 
Kees Cook
