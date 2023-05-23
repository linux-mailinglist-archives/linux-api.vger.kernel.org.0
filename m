Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42BEB70D3A8
	for <lists+linux-api@lfdr.de>; Tue, 23 May 2023 08:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbjEWGN0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 23 May 2023 02:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbjEWGNZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 23 May 2023 02:13:25 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C691E11A
        for <linux-api@vger.kernel.org>; Mon, 22 May 2023 23:13:23 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-55293697882so3924000eaf.0
        for <linux-api@vger.kernel.org>; Mon, 22 May 2023 23:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684822403; x=1687414403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hUm2yyJ18/we9uWrtAeUXp0j49gBv2i5N9eMM4ufGTs=;
        b=GG0g8WfCc6HHGFwZ3Q4geQfiXu8q0mdCit1KpbfmuKo749SACnWNdiuNzfsELaxDxW
         LAEkkcKi2zrFmWFOffqXs2e3dW8CfpjcPCUa2sucHosnzNkvZvKsLPFKstlTkCGDkLQe
         NG5teIrqiJbS4k11RkQTygNOthYMiHoCXdLm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684822403; x=1687414403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hUm2yyJ18/we9uWrtAeUXp0j49gBv2i5N9eMM4ufGTs=;
        b=MwwPwlGltvnR66IY5nY3LQWYiHEo02QsLNivxjjV0UIp0p+mK89PkOhlBq+KRQDAAj
         CAXZ4t/1foWTHEJ6NS+OZDtMap4p6m6IqImZ1smNjTWzQ++kpoMhHRdIBDJ6rKXAAO5m
         Nxz/P1/eslzkBbXoW1wlnBF19OjZDwseOAJNsWNemCSwt3CS9zPX+VUBkh4mQwrCRSWb
         dWUU6bG1m7gMzhHoqS9ZtUGFKdg/dDhze77lW4dx0ayD/dW9dhUPKzul65yq6AMcb/0j
         vOhpo829jUjpWC1A4VoeB+nB3GTwIMqNnxR1iueNfvh80//PbiC1/qYn3y/rvj0aZZ8s
         vK0Q==
X-Gm-Message-State: AC+VfDxr32NKMUAcBEKJyuFRKqrVxDsmU++6eTFavwWR7LDmitDk6Hi3
        B7WIgg8kfT0V2eGguXWQQ3vNSHo62NDMf7O+uLZkEQ==
X-Google-Smtp-Source: ACHHUZ6F23qb7h+EGPpL38qW3WqZRoDU/VkBc77G9UEijr6X5cpziPQd//zIqeBcgjTVAtPpmEIxz4tuh4xHXRC5BWg=
X-Received: by 2002:a4a:614b:0:b0:54f:49ad:1c8f with SMTP id
 u11-20020a4a614b000000b0054f49ad1c8fmr5596636ooe.1.1684822403143; Mon, 22 May
 2023 23:13:23 -0700 (PDT)
MIME-Version: 1.0
References: <ce44fc98-1234-fa53-5067-cd624866f44a@digikod.net>
 <20230518204549.3139044-1-enlightened@chromium.org> <a42875a0-d4c5-e2ac-d115-d4222e229f7d@schaufler-ca.com>
 <CAHC9VhTq0RgQ6xj86_BkZuAwy4kGy6eC8NVKFroEASNXP3uBxQ@mail.gmail.com>
In-Reply-To: <CAHC9VhTq0RgQ6xj86_BkZuAwy4kGy6eC8NVKFroEASNXP3uBxQ@mail.gmail.com>
From:   Jeff Xu <jeffxu@chromium.org>
Date:   Mon, 22 May 2023 23:13:12 -0700
Message-ID: <CABi2SkX0cqOMPeuw8CD28Q6UZihi0Hh7GT=dTmxaG-T_rayPfQ@mail.gmail.com>
Subject: Re: [PATCH v2] lsm: adds process attribute getter for Landlock
To:     Paul Moore <paul@paul-moore.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Shervin Oloumi <enlightened@chromium.org>, mic@digikod.net,
        linux-security-module@vger.kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, allenwebb@chromium.org,
        gnoack3000@gmail.com, areber@redhat.com, criu@openvz.org,
        linux-api@vger.kernel.org, jannh@google.com, brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, May 22, 2023 at 12:56=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Thu, May 18, 2023 at 5:26=E2=80=AFPM Casey Schaufler <casey@schaufler-=
ca.com> wrote:
> > On 5/18/2023 1:45 PM, Shervin Oloumi wrote:
> > > Adds a new getprocattr hook function to the Landlock LSM, which track=
s
> > > the landlocked state of the process. This is invoked when user-space
> > > reads /proc/[pid]/attr/domain
> >
> > Please don't add a Landlock specific entry directly in the attr/
> > directory. Add it only to attr/landlock.
> >
> > Also be aware that the LSM maintainer (Paul Moore) wants to move
> > away from the /proc/.../attr interfaces in favor of a new system call,
> > which is in review.
>
> What Casey said above.
>
> There is still some uncertainty around timing, and if we're perfectly
> honest, acceptance of the new syscalls at the Linus level, but yes, I
> would very much like to see the LSM infrastructure move away from
> procfs and towards a syscall API.  Part of the reasoning is that the
> current procfs API is ill-suited to handle the multiple, stacked LSMs
> and the other part being the complexity of procfs in a namespaced
> system.  If the syscall API is ultimately rejected, we will need to
> revisit the idea of a procfs API, but even then I think we'll need to
> make some changes to the current approach.
>
> As I believe we are in the latter stages of review for the syscall
> API, perhaps you could take a look and ensure that the current
> proposed API works for what you are envisioning with Landlock?
>
Which review/patch to look for the proposed API ?
I guess ChromeOS will need to backport to 5.10 when the proposal is accepte=
d.

Thanks
-Jeff


> --
> paul-moore.com
