Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994A96E5C9E
	for <lists+linux-api@lfdr.de>; Tue, 18 Apr 2023 10:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjDRIyk (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 18 Apr 2023 04:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbjDRIyh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 18 Apr 2023 04:54:37 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE8049C6
        for <linux-api@vger.kernel.org>; Tue, 18 Apr 2023 01:54:24 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ud9so71024258ejc.7
        for <linux-api@vger.kernel.org>; Tue, 18 Apr 2023 01:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1681808062; x=1684400062;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4k3WW0HYYEev3nuwv7vDX4T8/KUYMFlvnkJox7nmgfY=;
        b=rZgoEYmWcvDFqkdD0nxXePfvBvn3u5ZOur7mt+d4l5P9aQ9Gl/6qCmeGFgQdIDNixe
         zyd4xFj49Dbjf/+YBEzuWTsI5AHawGdIsTaxkF2LATuyXvEQCNPrCPnDQY7A7rpWaV3I
         Be0da+ecOYtTG5E4BsnQPezrWLtzlqR+4QPXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681808062; x=1684400062;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4k3WW0HYYEev3nuwv7vDX4T8/KUYMFlvnkJox7nmgfY=;
        b=Y1a7T3+iPBxK7ZZ5F9fIhIDB7wZwD3ZEEFidYLEj+j6EKINr77X3q4UQmT4RiV/E/p
         1GM6aU+hf46CSPFuRiylYOaS07UfRW2WrVwOpMY7/EEIRfmFehaUYy+QgdCxgAGcuMY8
         ERgTpcuaAi9NMoCzH9SEOP2/Aj3ObVw5o3Gnr2Gz7bqHFcG1Du2c0v8hfk/kIdGfETYB
         4/xodcnsV/CQ/cj5cN6Q7g+bTbnaE32miZB90QGAvD88pEvx5CCUoz4XYk3MOna95RsI
         70x3VW9+uu0UKyW/jmgR3lq4fx30eDWqZC6mQQqo08OXP/1dQC5bm8Eo4AeENrGJKDgX
         xRDQ==
X-Gm-Message-State: AAQBX9ec03nLMOXmMaWpGudmOF01OgPRUxVnOIhIjzmD+AX7uiGPsk+C
        rTiYH7zvVrjLq4fEDyR6rLIKDpOJkPublVR0cfSFMe6dt0Z4nIydayD6dQ==
X-Google-Smtp-Source: AKy350ZeR14T6BUocbJhKdgdvJG00gRRWuAG9wyFQ4gTSTVTWmefyGehGfMzmKL4FI9uxUOFNpYalzs+EfMXy3v9vew=
X-Received: by 2002:a17:906:149b:b0:948:b9ea:3302 with SMTP id
 x27-20020a170906149b00b00948b9ea3302mr10922599ejc.1.1681808062685; Tue, 18
 Apr 2023 01:54:22 -0700 (PDT)
MIME-Version: 1.0
References: <YnEeuw6fd1A8usjj@miu.piliscsaba.redhat.com> <e57733cd-364d-84e0-cfe0-fd41de14f434@bytedance.com>
 <CAJfpegsVsnjUy2N+qO-j4ToScwev01AjwUA0Enp_DxroPQS30A@mail.gmail.com> <CAOQ4uxhYi2823GiVn9Sf-CRGrcigkbPw2x1VQRV3_Md92gJnrw@mail.gmail.com>
In-Reply-To: <CAOQ4uxhYi2823GiVn9Sf-CRGrcigkbPw2x1VQRV3_Md92gJnrw@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 18 Apr 2023 10:54:11 +0200
Message-ID: <CAJfpegsLD-OxYfqPR7AfWbgE1EAPfWs672omt+_u8sYCMFB5Fg@mail.gmail.com>
Subject: Re: [LSF/MM TOPIC] fsinfo and mount namespace notifications
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Abel Wu <wuyun.abel@bytedance.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        lsf-pc <lsf-pc@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, 15 Apr 2023 at 13:06, Amir Goldstein <amir73il@gmail.com> wrote:

> You indicated that you would like to discuss the topic of
> "mount info/mount notification" in LSF/MM, so I am resurrecting
> this thread [1] from last year's topic.
>
> Would you be interested to lead a session this year?
> So far, it felt like the topic was in a bit of a stalemate.
>
> Do you have a concrete suggestion of how to escape this stalemate?
> I think it is better that we start discussing it a head of LSF/MM if we hope
> to reach consensus in LSF/MM, so that people will have a chance to
> get re-familiar with the problems and proposed solutions.

The reason for the stalemate is possibly that we are not trying to
solve the issue at hand...

So first of all, here's what we currently have:

- reading a process' mount table via /proc/$PID/mountinfo
   o mount parameters (ID, parent ID, root path, mountpoint path,
mount flags, propagation)
   o super block parameters (devnum, fstype, source, options)
   o need to iterate the whole list even if interested in just a single mount

- notification on mount table change using poll on /proc/$PID/mountinfo
   o no indication what changed
   o finding out what changed needs to re-parse possibly the whole
mountinfo file
   o this can lead to performance problems if the table is large and
constantly changing

- mount ID's do not uniquely identify a mount across time
  o when a mount is deleted, the ID can be immediately reused

The following are the minimal requirements needed to fix the above issues:

1) create a new ID for each mount that is unique across time; lets
call this umntid

2) notification needs to indicate the umntid that changed

3) allow querying mount parameters via umntid

And I think here's where it gets bogged down due to everyone having
their own ideas about how that interface should look like.

Proposals that weren't rejected so far:

- mount notifications using watch_queue

https://lore.kernel.org/all/159645997768.1779777.8286723139418624756.stgit@warthog.procyon.org.uk/

I also explored fsnotify infrastructure for this.  I think the API is
better fit, since we are talking about filesystem related events, but
notifications l would need to be extended with the mount ID.

- getxattr(":mntns:$ID:info",...)

https://lore.kernel.org/all/YnEeuw6fd1A8usjj@miu.piliscsaba.redhat.com/

Christian would like to see the xattr based interface replaced with a
new set of syscalls to avoid confusion with "plain" xattrs.

Thanks,
Miklos
