Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A6770CA1B
	for <lists+linux-api@lfdr.de>; Mon, 22 May 2023 21:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235517AbjEVT4f (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 22 May 2023 15:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234201AbjEVT4c (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 22 May 2023 15:56:32 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823C299
        for <linux-api@vger.kernel.org>; Mon, 22 May 2023 12:56:31 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-561c1768bacso85872987b3.1
        for <linux-api@vger.kernel.org>; Mon, 22 May 2023 12:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1684785390; x=1687377390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rRnMbGr+rJSuQK7vxXW3742k5RQT9jp89KAS7Rrs6jE=;
        b=YC83y56uMjO9NZ+Ns8uWAYGqw3GlASiXMRShnch0d7g7x1+VLpQ98bwPI3DZSLQ6rG
         ycpuhnXDQkvZ8GdQ6l+QhuJFQMeQ9zz31zYsJc9nTArtRIdUyZVnQAY/yPzMOMwqF09L
         PB5IOq66kChe9/DC0xfCV5KLGIGJ79Lotm9nRTdTrVjYuu7hWVDDeidTvbYV0SwZOpcD
         2omkv2i1ekuC+Vw4mg5isynrNGuzizylK4iArRQWJ6STkoLJLPwtM8vRdFcrh9gjlH2b
         pkJjfsF8IY1vXfmFQ8pTZ6ies1LxwiZ/oiETIlD667HP0GuJwWPCar9wopgoPtjDMBlk
         N7kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684785390; x=1687377390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rRnMbGr+rJSuQK7vxXW3742k5RQT9jp89KAS7Rrs6jE=;
        b=eB/xtTpn0vYL4JDpwiqHa3YWpVpel0QDEvs4wXk3ynDvSyqFt8khtH/u1v2Efh/LYM
         q1qSLd+7l2ccXQTyXlPfGixAnhxPjnzUppfpkaku6BFWjVoyCOLo8Acs3qnHmPoxNUVi
         JvHoivc1UjXhgEbzXD8BX+EoZaXsNLzGeIWuH9G/n7E8yxh43bzgXR3mn5PxkVKaF6vE
         vujFDqN01yRe8UreOCO3jo87/S66FnFz8LWG5rXyma991P9KbHhS4BH4fTPDKUO4V/rr
         POI5/bx3bFqJQEQH5TZ82ylCvvQal5Xi1GN/7apzkhd+Hf16FcQlFbS0pb/R4yHMjqZs
         TpqQ==
X-Gm-Message-State: AC+VfDwlcwVAsGeKAjUjvEalLsw8rjLdhkUY+MT6jqBOTL7cv2V+hSIL
        JC7FIMXcLp5QVtdC2fW2uK//9Z4uWvyPrdizhwFq
X-Google-Smtp-Source: ACHHUZ5okAQF3r/hM9jwhRY2FCDkCNw1uKx07HtlO3Nvzg8he2TuYBgJkbx6w+pA4nCX1T3g6PgK2ACGEomOR10pkbA=
X-Received: by 2002:a81:4e8b:0:b0:561:be3f:ae2c with SMTP id
 c133-20020a814e8b000000b00561be3fae2cmr11435118ywb.40.1684785390612; Mon, 22
 May 2023 12:56:30 -0700 (PDT)
MIME-Version: 1.0
References: <ce44fc98-1234-fa53-5067-cd624866f44a@digikod.net>
 <20230518204549.3139044-1-enlightened@chromium.org> <a42875a0-d4c5-e2ac-d115-d4222e229f7d@schaufler-ca.com>
In-Reply-To: <a42875a0-d4c5-e2ac-d115-d4222e229f7d@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 22 May 2023 15:56:19 -0400
Message-ID: <CAHC9VhTq0RgQ6xj86_BkZuAwy4kGy6eC8NVKFroEASNXP3uBxQ@mail.gmail.com>
Subject: Re: [PATCH v2] lsm: adds process attribute getter for Landlock
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Shervin Oloumi <enlightened@chromium.org>, mic@digikod.net,
        linux-security-module@vger.kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, jeffxu@chromium.org,
        allenwebb@chromium.org, gnoack3000@gmail.com, areber@redhat.com,
        criu@openvz.org, linux-api@vger.kernel.org, jannh@google.com,
        brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, May 18, 2023 at 5:26=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 5/18/2023 1:45 PM, Shervin Oloumi wrote:
> > Adds a new getprocattr hook function to the Landlock LSM, which tracks
> > the landlocked state of the process. This is invoked when user-space
> > reads /proc/[pid]/attr/domain
>
> Please don't add a Landlock specific entry directly in the attr/
> directory. Add it only to attr/landlock.
>
> Also be aware that the LSM maintainer (Paul Moore) wants to move
> away from the /proc/.../attr interfaces in favor of a new system call,
> which is in review.

What Casey said above.

There is still some uncertainty around timing, and if we're perfectly
honest, acceptance of the new syscalls at the Linus level, but yes, I
would very much like to see the LSM infrastructure move away from
procfs and towards a syscall API.  Part of the reasoning is that the
current procfs API is ill-suited to handle the multiple, stacked LSMs
and the other part being the complexity of procfs in a namespaced
system.  If the syscall API is ultimately rejected, we will need to
revisit the idea of a procfs API, but even then I think we'll need to
make some changes to the current approach.

As I believe we are in the latter stages of review for the syscall
API, perhaps you could take a look and ensure that the current
proposed API works for what you are envisioning with Landlock?

--=20
paul-moore.com
