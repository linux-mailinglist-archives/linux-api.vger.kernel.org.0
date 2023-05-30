Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4D7716BDC
	for <lists+linux-api@lfdr.de>; Tue, 30 May 2023 20:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233228AbjE3SEB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 30 May 2023 14:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233346AbjE3SDt (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 30 May 2023 14:03:49 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884AD188
        for <linux-api@vger.kernel.org>; Tue, 30 May 2023 11:03:46 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-555536b85a0so2399361eaf.2
        for <linux-api@vger.kernel.org>; Tue, 30 May 2023 11:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685469826; x=1688061826;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ATVoLozR2BePms8bg22SnJC3NdlK/27RxjAnUqa0huQ=;
        b=T21v+Kc++CJ0iWH1lmCIK4UrxKXvi2gXbYoCp8Abx1NOE95lsJJ09URJhaTCkJv8oB
         srMOos94M6CG5KiW/mMzmjFEM44IoUU+Ff/tD22FNe4N21IyvSJJ4P9i1AiPchlpEelr
         aT1SSWIyfX7wV1XgE3VWcXOufwObcIbepHXIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685469826; x=1688061826;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ATVoLozR2BePms8bg22SnJC3NdlK/27RxjAnUqa0huQ=;
        b=OjmBDl+jOgFmZ56P8ivd+RPwM72IEio1tjpKgrEmHKCqJyycCFebHOEYS4zOJqFUF1
         i3iucdHyOmazLNdcpte1rbDuhEYWxt91Y8oDt0KZffnnc2gdzPKdpN5R/hcTLukzwpu/
         FR7oA4i039YmMRSNNIiKTaQZ2BAt/+TbgzX6XtnYzSEmCqKQ4mS4rsOgRzxW8hI9lnBY
         cDFgQqbPAXZ+w0H34bTsDDAh/J3dyT/qiqRUHEmf2ALTakFA8pNzH6bWCuo665+IPKei
         Ojh0gpgA8Heh9JudgPZNyLi+60ipooHHCqnlaQRAadIkaRQWozOMmq+90H8vkB9XF3H2
         /R5Q==
X-Gm-Message-State: AC+VfDzU4upZNA/Ea3LsaE9yF/5haYpLEXOIQPcclHUuswgCKdJWROJa
        oGZpR8ntJs6l1JlyJ1OpqEMqmnnNW5ynffopvv2TbQ==
X-Google-Smtp-Source: ACHHUZ62iGx50VsUN76nFo7zEv3lAIi9jLbeY2S3k3Q9ix0Zq5izs3M/cJ6HniZbls7TJQJ3SWqBoTzQ43pPK3QqTvY=
X-Received: by 2002:a4a:4913:0:b0:555:8c22:a169 with SMTP id
 z19-20020a4a4913000000b005558c22a169mr1389099ooa.9.1685469825802; Tue, 30 May
 2023 11:03:45 -0700 (PDT)
MIME-Version: 1.0
References: <ce44fc98-1234-fa53-5067-cd624866f44a@digikod.net>
 <20230518204549.3139044-1-enlightened@chromium.org> <a42875a0-d4c5-e2ac-d115-d4222e229f7d@schaufler-ca.com>
 <CAHC9VhTq0RgQ6xj86_BkZuAwy4kGy6eC8NVKFroEASNXP3uBxQ@mail.gmail.com>
 <CABi2SkX0cqOMPeuw8CD28Q6UZihi0Hh7GT=dTmxaG-T_rayPfQ@mail.gmail.com> <7b8688f5-20bc-8130-2341-ff56bb365d5a@schaufler-ca.com>
In-Reply-To: <7b8688f5-20bc-8130-2341-ff56bb365d5a@schaufler-ca.com>
From:   Jeff Xu <jeffxu@chromium.org>
Date:   Tue, 30 May 2023 11:02:00 -0700
Message-ID: <CABi2SkUEUrwZ_HAVqX651iOQfXN6=Sdv4C=ihso5CSohXeo5uA@mail.gmail.com>
Subject: Re: [PATCH v2] lsm: adds process attribute getter for Landlock
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Shervin Oloumi <enlightened@chromium.org>, mic@digikod.net,
        linux-security-module@vger.kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, allenwebb@chromium.org,
        gnoack3000@gmail.com, areber@redhat.com, criu@openvz.org,
        linux-api@vger.kernel.org, jannh@google.com, brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

> >>
> >> As I believe we are in the latter stages of review for the syscall
> >> API, perhaps you could take a look and ensure that the current
> >> proposed API works for what you are envisioning with Landlock?
> >>
> > Which review/patch to look for the proposed API ?
>
> https://lore.kernel.org/lkml/20230428203417.159874-3-casey@schaufler-ca.com/T/
>
>
How easy is it to add a customized LSM with new APIs?
I'm asking because there are some hard-coded constant/macro, i.e.

+#define LSM_ID_LANDLOCK 111
(Do IDs need to be sequential ?)

+ define LSM_CONFIG_COUNT

Today, only security/Kconfig change is needed to add a new LSM, I think ?
