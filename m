Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3EE6B150D
	for <lists+linux-api@lfdr.de>; Wed,  8 Mar 2023 23:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjCHWZ6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 8 Mar 2023 17:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjCHWZy (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 8 Mar 2023 17:25:54 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCC2C1C1A
        for <linux-api@vger.kernel.org>; Wed,  8 Mar 2023 14:25:51 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id m8-20020a17090a4d8800b002377bced051so4084927pjh.0
        for <linux-api@vger.kernel.org>; Wed, 08 Mar 2023 14:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678314350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T45Iy3OV+OW/flDxF4MmO42sG5KpQ7XCkwp0OqDKye8=;
        b=DRE6M29hUUAts1s+nHPRdk4EsIoEAm6H0pOgVdkME4cTwCpb0v9adgQEkHHwgLr/bD
         udAvqohDoEdQ/Ywvr4mB3wMuaRvET3izoqtAqNZ5uf+Y7plCsOcU7pIudVW7DvVuvSNy
         lbfG/J5QpkuPa0UvSdDPL1zn810f/F/ibrYrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678314350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T45Iy3OV+OW/flDxF4MmO42sG5KpQ7XCkwp0OqDKye8=;
        b=dKhlXErKJTSlTllVHTYkXJQLEeTJp10/Z7VgvzUYcmqGSM4hY3Syh87vcqgsKYANkO
         +jIhFhIBfMKGrg1gDr6WuxySlWx6roO/ZrzOnqxZcB7WtWLGgwJMEm1HWXQHZg3CFI6u
         n7GkBJKjIOQ26KFSlJ3zHEQ+rXtm3DgCI2VYXgaKDPxXhCFEIKDd8UxcoL22x7Qlk0SS
         7BIQu7Tyg6SPVuhxP/TZ59e7AeLQzopSjtOXljLCSBbO8n39i0A34MfpdMTCHfkmZjn+
         XGR2JZlbvIyYeP0NDlmKVhn36RZ955pnA3QL0yJGKD0pGy01F/OTKz+uL1Mg821JHuTT
         YAYg==
X-Gm-Message-State: AO0yUKWNKCj3rDAlnc4+UgBqta3snBYUjtclwVw1QXmRYpNX7ggM6uMs
        6pRh9DOAA9UwjsSlzdMKxtkqcmkvckJvP1ki6o6BFw==
X-Google-Smtp-Source: AK7set9mXuDbv0wvZzkAoKLHRMLLX6pABGaw7DEFgax+R2IVRXschlVKrhOoLypEtkaLbm1nGzQ8d02hWIm4+jPwCcc=
X-Received: by 2002:a17:902:ef95:b0:19b:8be:33dc with SMTP id
 iz21-20020a170902ef9500b0019b08be33dcmr7511259plb.6.1678314350307; Wed, 08
 Mar 2023 14:25:50 -0800 (PST)
MIME-Version: 1.0
References: <20230302185257.850681-1-enlightened@chromium.org> <247f3194-2dd2-1414-0a4d-6e41addf5e64@digikod.net>
In-Reply-To: <247f3194-2dd2-1414-0a4d-6e41addf5e64@digikod.net>
From:   Shervin Oloumi <enlightened@chromium.org>
Date:   Wed, 8 Mar 2023 14:25:39 -0800
Message-ID: <CAMb9sTir8Gde=DwZ9LnW2Hq7YmSZ13u_aX8AyR=JEQWGBhCvAQ@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Thanks all for the feedback. This is in reply to Micka=C3=ABl, but should
answer G=C3=BCnther's questions as well.

> It would help to know exactly what are your needs short term, and long
> term. As G=C3=BCnther is wondering, what about nested sandboxing?

Our plan is to use the "landlocked" process attribute defined in the
patch to determine the sandbox state of the system processes and send
information to our metrics server regarding Landlock coverage. For
example, the percentage of processes on the system that are sandboxed
using Landlock.

Given that we use Landlock in a very specific and controlled way, we
are not concerned about the inheritance behavior and nested policies,
at least for the use case of metrics. When daemons are launched in
ChromiumOS, they have a pre-defined sandboxing configuration that
dictates whether Landlock should be applied or not. So this attribute
would help us verify that the processes running on devices in the wild
indeed have the general sandboxing state that we expect and the
reality matches our expectation.

Long-term, it would be useful to learn more information about domains
and policies through the process attribute interface, but we do not
currently have a need for that, apart from maybe doing troubleshooting
when defining Landlock rules for system daemons.

> I'm thinking about a new /sys/kernel/security/landlock filesystem to be
> able to audit Landlock domains (i.e. sandboxes). As for your use case,
> it would be useful to be able to tie a process to a Landlock domain
> thanks to IDs.

I think this goes beyond the scope for our current needs, but
certainly a nice feature that we could potentially use in the future.
So given this, I was wondering what would be the minimum changes we
can make now (if any) that would serve our purpose AND would be
compatible with your long-term vision, without getting too deep into
the implementation of broader concepts. We are flexible on the
approach for querying the landlocked property (for example whether it
is based on the presence of a /proc/.../attr/domain or actually
reading an attribute).

> Here are the guiding principles I think would make sense:
> 1. A sandboxed thread shall not be able to directly know if it is
> sandbox nor get any specific information from it's restrictions. The
> reason for this principle is to avoid applications to simply jump to
> conclusions (and change behavior) if they see that they are sandboxed
> with Landlock, instead of trying to access resources and falling back
> accordingly. A thread should only be able to inspect its
> own/children/nested domains.
> 2. Access to any Landlock domain information should be checked according
> to PTRACE_MODE_READ_FSCREDS, the Landlock domain hierarchy (cf.
> ptrace.c:domain_scope_le), and the first principle.

One thing worth noting is that we use a system daemon to read process
attributes. We have the ptrace_scope set to 1 and the daemon reading
the attributes does have cap_sys_ptrace, however it is not related to
the other processes on the system. Do you see this as a problem given
principle#1?

> 3. Any (domain) ID should be unique to the whole system (or maybe to the
> reader's PID namespace, and then in theory relative to the /proc
> content) to make it possible to compare Landlock domains (like
> /proc/[pid]/ns/* symlinks enable), and avoid trivial races.
> 4. These IDs should be the same during the whole lifetime of the related
> domain.
> 5. These IDs should not enable to infer information from other Landlock
> domains (e.g. how many are in use, current and parent domains), nor the
> kernel internals (e.g. addresses).
> 6. These IDs should not be sequential nor easily guessed to avoid
> anti-patterns (cf. file descriptors).
> 7. These IDs should be CRIU-friendly, to be able to easily restore such
> state. This doesn't help the previous principles and I don't know how/if
> CRIU supports namespace IDs though.

Since these points are regarding the properties of the domain IDs,
they should not interfere with anything we would implement for
determining the process sandbox status in any initial patch, but are
good to know.

> It would be nice if the /proc/[pid]/attr/landlock directory would only
> exists if Landlock is enabled.

This is the current default behavior I believe.

> Similarly, /proc/[pid]/attr/landlock/domain should only exist (or be
> viewable) for a thread if [pid] is part of one of its child domain.

I am not sure if this is a blocker for our model of a single daemon
querying the attribute for all processes. Are you suggesting that the
file would not exist from the view of the other processes if they are
not the parent process?

> For now, I don't see any file in /proc/[pid]/attr/landlock/ other than
> "domain" that would make sense, but a dedicated directory is useful anywa=
y.

Determining the sandbox status of processes based on the existence of
/proc/[pid]/landlock/domain would serve our simple use case, pending
the open questions/potential blockers above and a clarification on
minimum requirements for an initial version.
