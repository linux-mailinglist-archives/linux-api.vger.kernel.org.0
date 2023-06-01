Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B37F71F42D
	for <lists+linux-api@lfdr.de>; Thu,  1 Jun 2023 22:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbjFAUsq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 1 Jun 2023 16:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbjFAUso (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 1 Jun 2023 16:48:44 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DD819F
        for <linux-api@vger.kernel.org>; Thu,  1 Jun 2023 13:48:42 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-557d1360112so862535eaf.3
        for <linux-api@vger.kernel.org>; Thu, 01 Jun 2023 13:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685652522; x=1688244522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ELf/zkRePONHTGzrk/i/VUoCMd1oMZvqTvJnqJDJ1xI=;
        b=UffwDji+JYy1TTchdaMJV/zMDfuEESReFBA49XtmWleQqqOWKTi76DzgK0hZQ0mWRH
         4C+xrzIygr4GSk9OwqIY0YouY5NNplcq7kLTmVsh9ZmkqD9E486OPZ55zzR/HvdDwgpp
         llFDNlueaByPFd27TEhM4fbPc8yv08qZtgY6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685652522; x=1688244522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ELf/zkRePONHTGzrk/i/VUoCMd1oMZvqTvJnqJDJ1xI=;
        b=B/069BzwAm3CgpnJegcf3lJYC0b5KKg7CLI+qPE0TUVwjTVw/dd4P0A//n8pUjBgD3
         usVbF+kCvO1HqcdLhsbx+d2lI+0J6ooWkfley490thwjW6jspDKqCVJCXL9JHFQuE5Lp
         HWZrud0ymJINK7uleGevOzXJg42aUysj0UOzp353/+jZnJLPTAD5IobIdCKL8v/m/Hop
         +j7E/nyJFWMlBsxHxW2yp7v8cjg0rco6lhhEvtAQ62VwvwvQjW8qmkZgbfx+Tr9GjWzS
         Tr1Ca9ub+WV2Lw4vahCACuklWm3SjdKo5AWv1dyiuS5Hs1wX/KuS/sE7LuIP8jHeujOW
         /CxA==
X-Gm-Message-State: AC+VfDyXevftOeJ1r+tSyyRIaaKZWupa8NdwIPwbkJKRo+putcO30Mtp
        Zxyt5ALAgD7rFRNZLxSyOqa3Quhh0hhNwziwec4DrQ==
X-Google-Smtp-Source: ACHHUZ5QHgkOvg57BcOHAl/rVyRFlXZ6p1Xl7WZDqS4FGNBStWyf6S7TVkxX1Ccj4enMf94fpCtCtVCZImPHqevf7Sg=
X-Received: by 2002:a4a:4585:0:b0:555:9b48:93de with SMTP id
 y127-20020a4a4585000000b005559b4893demr5514916ooa.5.1685652521710; Thu, 01
 Jun 2023 13:48:41 -0700 (PDT)
MIME-Version: 1.0
References: <ce44fc98-1234-fa53-5067-cd624866f44a@digikod.net>
 <20230518204549.3139044-1-enlightened@chromium.org> <a42875a0-d4c5-e2ac-d115-d4222e229f7d@schaufler-ca.com>
 <CAHC9VhTq0RgQ6xj86_BkZuAwy4kGy6eC8NVKFroEASNXP3uBxQ@mail.gmail.com>
 <CABi2SkX0cqOMPeuw8CD28Q6UZihi0Hh7GT=dTmxaG-T_rayPfQ@mail.gmail.com>
 <CAHC9VhRD8kfkHr2gfFp10txdDwE0NGSJQd08bRojeJKiKtqq6Q@mail.gmail.com>
 <1225a567-4ff5-462e-0db6-1a88a748d787@digikod.net> <b4825033-471c-ba32-530f-b0235356d55b@digikod.net>
 <aa2e3c9c-eac4-237d-02d0-4574f602563d@schaufler-ca.com> <CABi2SkWxZwLDfo=LjLA+cXGvpNfv26ZmD5dDm+AjgD5XgNfTmw@mail.gmail.com>
 <e1db62f4-32c5-d784-ba4e-5acc242bc00c@schaufler-ca.com> <e7c8a996-d98c-efac-3b12-dd6d66e421c3@digikod.net>
In-Reply-To: <e7c8a996-d98c-efac-3b12-dd6d66e421c3@digikod.net>
From:   Jeff Xu <jeffxu@chromium.org>
Date:   Thu, 1 Jun 2023 13:48:30 -0700
Message-ID: <CABi2SkUFe7zOFi3Vr-A6bTGytOdeZkvsPfxxLq9+b0vHfa-bkA@mail.gmail.com>
Subject: Re: [PATCH v2] lsm: adds process attribute getter for Landlock
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Paul,

On Wed, May 31, 2023 at 6:26=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
> >>>
> >>>
> >> If I understand correctly:
> >> 1> A new lsm syscall - lsm_get_pid_attr():  Landlock will return the
> >> process's landlock sandbox status: true/false.
> >
> > There would have to be a new LSM_ATTR_ENFORCMENT to query.
> > Each LSM could then report what, if any, value it choose to.
> > I can't say whether SELinux would take advantage of this.
> > I don't see that Smack would report this attribute.
>
> I think such returned status for LSM_ATTR_ENFORCMENT query would make
> sense, but the syscall could also return -EPERM and other error codes.
>
>
> >
> >>
> >> Is this a right fit for SELinux to also return the process's enforcing
> >> mode ? such as enforcing/permissive.
>
> Paul could answer that, but I think it would be simpler to have two
> different queries, something like LSM_ATTR_ENFORCMENT and
> LSM_ATTR_PERMISSIVE queries.
>
Hi Paul, what do you think ? Could SELinux have something like this.

Thanks!
-Jeff
