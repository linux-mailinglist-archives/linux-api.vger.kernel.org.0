Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE10A7089B2
	for <lists+linux-api@lfdr.de>; Thu, 18 May 2023 22:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjERUo1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 18 May 2023 16:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjERUo0 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 18 May 2023 16:44:26 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A72E7F
        for <linux-api@vger.kernel.org>; Thu, 18 May 2023 13:44:25 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-2535d86a41bso941523a91.3
        for <linux-api@vger.kernel.org>; Thu, 18 May 2023 13:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684442665; x=1687034665;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ygU6GkDtTB7PyyCUUNjlAcOm8klFTM9An5KCSiAa+24=;
        b=bc02NjX5vo5t3nm/ZE5yn+nghUpC5WHGWyIvB5npgis+MGSOLi6OBdaVqg0b8LPBsP
         FQvHJk46Redn4J0FjH4mGSXnSuP7cd9gk6x6kCSZlvsSCv5ayzNofww3DiwnjSbuI8YT
         U16DI3PnJorO9VVcFMRarMb2kP4YNJXwJGwvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684442665; x=1687034665;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ygU6GkDtTB7PyyCUUNjlAcOm8klFTM9An5KCSiAa+24=;
        b=Ff6+ZtmrxPl8cl2W97ccWPk0zpPtQuYUNVWFNwGYryGyMexqOV9dxk91vwYm9qPXwX
         zVRigyVXGDcabMcpCEGkMFiggqfxKkbCXQXDZEAGwGLb36LKluon5GvGwNYfCVnClRuH
         LEXKPfzotIy0S5u8I32pBqu44imxvIzuxPBL6C38FjpBUw9KY72pC0aj/7ctvqUCFA2K
         alzRR/CS2yVgbq4ro9lFSaVdNjpjjUWUuoC1OU+ei2XX0SKlMx4VioiQrI5V4oGJsu6O
         T6sC2iVG4OjeLyJiq/C36cWt2tY6DMSrudqChp0T9N7O484HtEWaCikDz7M7nOHOoBrg
         DRiQ==
X-Gm-Message-State: AC+VfDzP2W80NlD1rZ8zUR+o3HHHipBHx6ZZNhSnWgTPTMNFWif1/gUv
        RF4HMpsiiJ4W6sprpMsH/HwtIjwNgCnfZ/p3yD/aEw==
X-Google-Smtp-Source: ACHHUZ65Z8Z2+qYx24McVvidVeh7tlEKvhXvP6Lkwy3WnU+i5tH1SOo6OhiUFGotCqEK2B7/xiIp7AiOqP7leVO1Y0w=
X-Received: by 2002:a17:90b:f91:b0:24e:e6c:794c with SMTP id
 ft17-20020a17090b0f9100b0024e0e6c794cmr3990692pjb.38.1684442664911; Thu, 18
 May 2023 13:44:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230302185257.850681-1-enlightened@chromium.org>
 <247f3194-2dd2-1414-0a4d-6e41addf5e64@digikod.net> <CAMb9sTir8Gde=DwZ9LnW2Hq7YmSZ13u_aX8AyR=JEQWGBhCvAQ@mail.gmail.com>
 <ce44fc98-1234-fa53-5067-cd624866f44a@digikod.net>
In-Reply-To: <ce44fc98-1234-fa53-5067-cd624866f44a@digikod.net>
From:   Shervin Oloumi <enlightened@chromium.org>
Date:   Thu, 18 May 2023 13:44:13 -0700
Message-ID: <CAMb9sThs2QXid0LZ3gwtfJoJUM3mpK0=nobOGpicde7jnuAJ5Q@mail.gmail.com>
Subject: Re: [PATCH 0/1] process attribute support for Landlock
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     linux-security-module@vger.kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, jeffxu@chromium.org,
        allenwebb@chromium.org,
        =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>,
        Adrian Reber <areber@redhat.com>, criu@openvz.org,
        Linux API <linux-api@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Sorry for the delay on this. I think there is a fundamental issue here
that needs to be resolved first, and that is the limitation of the
kernel that only one LSM's hook function can be called through the
procfs attribute interface. This is a blocker for us (and I imagine
for others), since implementing any LandLock attribute API would block
the existing SELinux hook function, which is used to surface domain
information. `ps` also uses it to display domain information when you
pass `-Z`. Please note, this is independent of which path and filename
we use for LandLock. Even when the "domain" file is placed under a
different directory, for example `/proc/[pid]/attr/landlock/domain`
the kernel only calls the Landlock hook function for any interaction
with any files under attr (the kernel always calls only the hook
function for the first loaded LSM in the kernel config). So if anyone
in this thread has any information on whether there is work on
progress for addressing this issue, that would be helpful.

As for the patch, I will just provide what I have so far, which I
think is more in line with the approach you suggested, so that it can
perhaps at some point be useful, once the above limitation is
resolved.

> Yes, the approach I suggested, check the /proc/.../attr/landlock/domain
> presence would enable you to check the landlocked state of a process. It
> should not change much from your initial patch. In fact it will be
> quicker to check because there is no need for the open/read/close
> syscalls, but only faccessat2.

I played around with this idea but ran into a problem; I'm not sure if
it is possible to implement a behavior where the existence/viewability
of the `/proc/.../attr/landlock/domain` is conditional. The `domain`
file is predefined with set permissions in `fs/proc/base.c` (as done
in the patch) and it is always present if landlock is enabled.
Additionally, the `landlock_getprocattr` hook function only gets
called when the file `/proc/.../attr/landlock/domain` is opened and
read, so I'm not sure how the file visibility can be manipulated.

The closest way I can think of to imitate the suggested behavior is to
return `EACCES` in the hook function if the checking process domain is
not related to the target process domain and return "none" (indicating
there is no Lanldock domain associated with this process) if the
domain check passes and the target process is not landlocked. In cases
where the access check passes (or when the checking process is not
landlocked) and the target process is landlocked reading the file
could just return nothing (maybe in the future this will return the
domain ID...TBD).
