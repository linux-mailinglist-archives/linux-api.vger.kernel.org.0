Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B9E716BE6
	for <lists+linux-api@lfdr.de>; Tue, 30 May 2023 20:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbjE3SGO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 30 May 2023 14:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbjE3SGM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 30 May 2023 14:06:12 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A488F
        for <linux-api@vger.kernel.org>; Tue, 30 May 2023 11:06:11 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-19a427d7b57so2258274fac.2
        for <linux-api@vger.kernel.org>; Tue, 30 May 2023 11:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685469970; x=1688061970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7WRh4ii68vVijZcHEibAPvhm7wB3t2DgvK1gWdbP0w=;
        b=SR6CZIAZ5SrMXVefyj6q4AWjVzk+3nx5ztjEYVIDzHaQlSWPlZLLJS3fKnd20JH3af
         XgTNLL0sKfPaQHVad3CXjU9BxRXsrG1DsnWejL5KS5V95z6R5dH7MsxnXhJlk/1ztLRh
         eWK2KR/Mer2KgvCMxN8lVOTO0jKfjrdKUqPT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685469970; x=1688061970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p7WRh4ii68vVijZcHEibAPvhm7wB3t2DgvK1gWdbP0w=;
        b=GOKcJzgR/j/eGID01eh4zVSKR4CeHBIHJZ/BQ91J8crqYFxNBeJYZMn9UX9crod1YM
         iRGJCmsd2we82x8aCUdRsKRG1EgdxEjtHItn5PwzOIkW3aPum6P/5cBrwBNvtlvQB9N3
         AXUUlNegU6L7+kj35kWp57Xj8gERkl6pfbacJFisj5xguitBLvcy4oY9CiflZNIcRlLJ
         3yChMHAfH+PVfREtCBTLKn2lcwLNP5dJnRmMNPrkWaDKMhzCNj5idMl+1/tYHtaKn3ny
         5jv1FYcSTxMzZIDGBAW001kSE5s0oPFJaEJOZjrqTDjNY1RkpqvZCXSSxvpsSMqWKTyB
         5Jdg==
X-Gm-Message-State: AC+VfDyMYlXY7BM4g6zYNgTRbUhkmrLKfXcKt8t6+SKNg2tJ0UD1dJ86
        ezKyRzWIAbW0jGNZ9Wbeirc4ePB4wJT3yrWoIKHwJw==
X-Google-Smtp-Source: ACHHUZ7qfBuWJ7g/cUNl+4SloyhS1Jw/vsZzM5+CPBT1v63IbYJcCNJUmCOE72tByfzCCQdV4OnJwFRtxt2hx6Ct028=
X-Received: by 2002:a05:6871:c10d:b0:196:87c5:8881 with SMTP id
 yq13-20020a056871c10d00b0019687c58881mr1376299oab.10.1685469970177; Tue, 30
 May 2023 11:06:10 -0700 (PDT)
MIME-Version: 1.0
References: <ce44fc98-1234-fa53-5067-cd624866f44a@digikod.net>
 <20230518204549.3139044-1-enlightened@chromium.org> <a42875a0-d4c5-e2ac-d115-d4222e229f7d@schaufler-ca.com>
 <CAHC9VhTq0RgQ6xj86_BkZuAwy4kGy6eC8NVKFroEASNXP3uBxQ@mail.gmail.com>
 <CABi2SkX0cqOMPeuw8CD28Q6UZihi0Hh7GT=dTmxaG-T_rayPfQ@mail.gmail.com>
 <CAHC9VhRD8kfkHr2gfFp10txdDwE0NGSJQd08bRojeJKiKtqq6Q@mail.gmail.com>
 <1225a567-4ff5-462e-0db6-1a88a748d787@digikod.net> <b4825033-471c-ba32-530f-b0235356d55b@digikod.net>
 <aa2e3c9c-eac4-237d-02d0-4574f602563d@schaufler-ca.com>
In-Reply-To: <aa2e3c9c-eac4-237d-02d0-4574f602563d@schaufler-ca.com>
From:   Jeff Xu <jeffxu@chromium.org>
Date:   Tue, 30 May 2023 11:05:00 -0700
Message-ID: <CABi2SkWxZwLDfo=LjLA+cXGvpNfv26ZmD5dDm+AjgD5XgNfTmw@mail.gmail.com>
Subject: Re: [PATCH v2] lsm: adds process attribute getter for Landlock
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Paul Moore <paul@paul-moore.com>,
        Shervin Oloumi <enlightened@chromium.org>,
        linux-security-module@vger.kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, allenwebb@chromium.org,
        gnoack3000@gmail.com, areber@redhat.com, criu@openvz.org,
        linux-api@vger.kernel.org, jannh@google.com, brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, May 25, 2023 at 9:28=E2=80=AFAM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> On 5/24/2023 9:02 AM, Micka=C3=ABl Sala=C3=BCn wrote:
> >
> > On 24/05/2023 17:38, Micka=C3=ABl Sala=C3=BCn wrote:
> >>
> >> On 23/05/2023 23:12, Paul Moore wrote:
> >>> On Tue, May 23, 2023 at 2:13=E2=80=AFAM Jeff Xu <jeffxu@chromium.org>=
 wrote:
> >>>> On Mon, May 22, 2023 at 12:56=E2=80=AFPM Paul Moore <paul@paul-moore=
.com>
> >>>> wrote:
> >>>>> On Thu, May 18, 2023 at 5:26=E2=80=AFPM Casey Schaufler
> >>>>> <casey@schaufler-ca.com> wrote:
> >>>>>> On 5/18/2023 1:45 PM, Shervin Oloumi wrote:
> >>>>>>> Adds a new getprocattr hook function to the Landlock LSM, which
> >>>>>>> tracks
> >>>>>>> the landlocked state of the process. This is invoked when
> >>>>>>> user-space
> >>>>>>> reads /proc/[pid]/attr/domain
> >>>>>>
> >>>>>> Please don't add a Landlock specific entry directly in the attr/
> >>>>>> directory. Add it only to attr/landlock.
> >>>>>>
> >>>>>> Also be aware that the LSM maintainer (Paul Moore) wants to move
> >>>>>> away from the /proc/.../attr interfaces in favor of a new system
> >>>>>> call,
> >>>>>> which is in review.
> >>>>>
> >>>>> What Casey said above.
> >>>>>
> >>>>> There is still some uncertainty around timing, and if we're perfect=
ly
> >>>>> honest, acceptance of the new syscalls at the Linus level, but yes,=
 I
> >>>>> would very much like to see the LSM infrastructure move away from
> >>>>> procfs and towards a syscall API.  Part of the reasoning is that th=
e
> >>>>> current procfs API is ill-suited to handle the multiple, stacked LS=
Ms
> >>>>> and the other part being the complexity of procfs in a namespaced
> >>>>> system.  If the syscall API is ultimately rejected, we will need to
> >>>>> revisit the idea of a procfs API, but even then I think we'll need =
to
> >>>>> make some changes to the current approach.
> >>>>>
> >>>>> As I believe we are in the latter stages of review for the syscall
> >>>>> API, perhaps you could take a look and ensure that the current
> >>>>> proposed API works for what you are envisioning with Landlock?
> >>
> >> I agree, and since the LSM syscalls are almost ready that should not
> >> change much the timing. In fact, extending these syscalls might be
> >> easier than tweaking the current procfs/attr API for Landlock specific
> >> requirements (e.g. scoped visibility). We should ensure that these
> >> syscalls would be a good fit to return file descriptors, but in the
> >> short term we only need to know if a process is landlocked or not, so =
a
> >> raw return value (0 or -errno) will be enough.
> >>
> >> Mentioning in the LSM syscalls patch series that they may deal with (a=
nd
> >> return) file descriptors could help API reviewers though.
> >
> > It should be kept in mind that the current LSM syscalls only deal with
> > the calling task, whereas the goal of this Landlock patch series is to
> > inspect other tasks. A new LSM syscall would need to be created to
> > handle pidfd e.g., named lsm_get_proc_attr() or lsm_get_pid_attr().
>
> I think it would be lsm_get_pid_attr(). Yes, it's the obvious next step.
>
> >
> > I'm not sure if this should be a generic LSM syscall or a Landlock
> > syscall though. I have plan to handle processes other than the caller
> > (e.g. to restrict an existing process hierarchy), so thinking about a
> > Landlock-specific syscall could make sense.
> >
> > To summarize, creating a new LSM syscall to deal with pidfd and to get
> > LSM process "status/attr" looks OK. However, Landlock-specific
> > syscalls to deal with Landlock specificities (e.g. ruleset or domain
> > file descriptor) make more sense.
> >
> > Having one LSM-generic syscall to get minimal Landlock attributes
> > (i.e. mainly to know if a process is sandboxed), and another
> > Landlock-specific syscall to do more things (e.g. get the domain file
> > descriptor, restrict a task) seems reasonable. The second one would
> > overlap with the first one though. What do you think?
>
> I find it difficult to think of a file descriptor as an attribute of
> a process. To my (somewhat unorthodox) thinking a file descriptor is
> a name for an object, not an attribute of the object. You can't access
> an object by its attributes, but you can by its name. An attribute is
> a description of the object. I'm perfectly happy with lsm_get_pid_attr()
> returning an attribute that is a file descriptor if it describes the
> process in some way, but not as a substitute for opening /proc/42.
>
>

If I understand correctly:
1> A new lsm syscall - lsm_get_pid_attr():  Landlock will return the
process's landlock sandbox status: true/false.

Is this a right fit for SELinux to also return the process's enforcing
mode ? such as enforcing/permissive.

2> Landlock will have its own specific syscall to deal with Landlock
specificities (e.g. ruleset or domain file descriptor).
