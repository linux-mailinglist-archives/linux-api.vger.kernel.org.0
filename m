Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5E6214D8E
	for <lists+linux-api@lfdr.de>; Sun,  5 Jul 2020 17:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbgGEPMB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 5 Jul 2020 11:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728088AbgGEPMA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 5 Jul 2020 11:12:00 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA9EC08C5E1
        for <linux-api@vger.kernel.org>; Sun,  5 Jul 2020 08:12:00 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id l12so39722141ejn.10
        for <linux-api@vger.kernel.org>; Sun, 05 Jul 2020 08:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BI1aAShmO7FXnwtN8B6Od+9nVsaMtVkeWnOGj2Zvm4Y=;
        b=1/6AOOiCg9ot1+F9UhkykucC0qMYgzK2GA9zYzKmMovooAnH48coFkCRo57BXWCcAp
         7CF9ClAVqv7j/oaBJkTGbl26Rszr/MUIfDjdNl7f5JnJxKj2yn0TKisOxrCwtEbFgNGQ
         /PqTAREqKfODffSK5H0TJGvTykPpy5976yQ7kuXJRMMseZOA5Ew/izF5q5DOEnUEoRD4
         ESr2tMdE8VI3TJe1XP8JUoKk5p9bUKtecSGxZUYV+q3k6YAqd72YHNOSHy2+GpdRqEFx
         dcvTHlVfR+822lyGWe9L3viPVcELzcQa2U96GrkmRWDqUDYx+kBFP2kg/4CFOsa4vnMk
         aSxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BI1aAShmO7FXnwtN8B6Od+9nVsaMtVkeWnOGj2Zvm4Y=;
        b=FovU+6h20c/ay9QRPkpOJh03wLuk+8sBB7vT8J5R5rbaVsrjdE7gxDopdpeNd9aIdN
         8xyGvABrMxLIeZ6Q5H2me08TKEa+IT3J3ji20Kb9no814Mscl/8GQjyT/QCkk1BTJxxK
         q3qJjv23Wa9rdkovvEoz7C7ObYBQgI90VN/Lv9WTmPj59ixRhTeLNYkADBt9OAdVdPJw
         E20UrIQDXB8ipMEtJJkZvxcmlAdVA7S8KaFjJ9wvRgo+5liCnTdm+BryLEfLzawqTU3d
         V3FSJ2qEBoTPToWevyDXN8qnMzihQfac+ZwJgw3vBWYqass1pwI91Z6wVSrAs/Tkyf3W
         tYjA==
X-Gm-Message-State: AOAM530Th2wiGUEms6ViDgi6UGpVTWx6unkPQSfyyJGtzaUzv5p4EIdo
        QSSadpNsEr/MCCHhEEr3BlZImd7SH+UpVspYYwYn
X-Google-Smtp-Source: ABdhPJy+1+ndZZah7VkLTSj7twGu3m1RKvwdW+PIAE3WsheefQt0o8KCRqSrelgLi4drC0Gf6mOHLfy4/pYyZRxzQXY=
X-Received: by 2002:a17:906:1a59:: with SMTP id j25mr37962178ejf.398.1593961918982;
 Sun, 05 Jul 2020 08:11:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593198710.git.rgb@redhat.com> <b6cb5500cfd7e8686ac2a7758103688c2da7f4ce.1593198710.git.rgb@redhat.com>
In-Reply-To: <b6cb5500cfd7e8686ac2a7758103688c2da7f4ce.1593198710.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 5 Jul 2020 11:11:47 -0400
Message-ID: <CAHC9VhRvuu-_+gh9ejr0sFDNR6erV2BAig6qrT9gOEB6GczXvw@mail.gmail.com>
Subject: Re: [PATCH ghak90 V9 13/13] audit: add capcontid to set contid
 outside init_user_ns
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        sgrubb@redhat.com, Ondrej Mosnacek <omosnace@redhat.com>,
        dhowells@redhat.com, simo@redhat.com,
        Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>, ebiederm@xmission.com,
        nhorman@tuxdriver.com, Dan Walsh <dwalsh@redhat.com>,
        mpatel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, Jun 27, 2020 at 9:24 AM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> Provide a mechanism similar to CAP_AUDIT_CONTROL to explicitly give a
> process in a non-init user namespace the capability to set audit
> container identifiers of individual children.
>
> Provide the /proc/$PID/audit_capcontid interface to capcontid.
> Valid values are: 1==enabled, 0==disabled
>
> Writing a "1" to this special file for the target process $PID will
> enable the target process to set audit container identifiers of its
> descendants.
>
> A process must already have CAP_AUDIT_CONTROL in the initial user
> namespace or have had audit_capcontid enabled by a previous use of this
> feature by its parent on this process in order to be able to enable it
> for another process.  The target process must be a descendant of the
> calling process.
>
> Report this action in new message type AUDIT_SET_CAPCONTID 1022 with
> fields opid= capcontid= old-capcontid=
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  fs/proc/base.c             | 57 +++++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/audit.h      | 14 ++++++++++++
>  include/uapi/linux/audit.h |  1 +
>  kernel/audit.c             | 38 ++++++++++++++++++++++++++++++-
>  4 files changed, 108 insertions(+), 2 deletions(-)

This seems very similar to the capable/ns_capable combination I
mentioned in patch 11/13; any reasons why you feel that this might be
a better approach?  My current thinking is that the capable/ns_capable
approach is preferable as it leverages existing kernel mechanisms and
doesn't require us to reinvent the wheel in the audit subsystem.


--
paul moore
www.paul-moore.com
