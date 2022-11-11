Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F666252B6
	for <lists+linux-api@lfdr.de>; Fri, 11 Nov 2022 05:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbiKKEli (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 10 Nov 2022 23:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiKKElg (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 10 Nov 2022 23:41:36 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64C16A755
        for <linux-api@vger.kernel.org>; Thu, 10 Nov 2022 20:41:31 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id k1so4192923vsc.13
        for <linux-api@vger.kernel.org>; Thu, 10 Nov 2022 20:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IiYBUrLnAPnSzUH+5luFf4rsxd6j3SEXozYrQ1VG+Vs=;
        b=kbRjL4aEWeLaFURRB8LSsLsdgoMX2ZSVARyIwGsueXmJZGqGr/vEp/rxDe4KUrq23/
         SitXGbompn1PCKKVdCmSFg6SAcZcqBAHbE1oUc5STExqcm9qy2ALvca6TQAhUYc4gJmG
         Bw9okzVaVlrQIjfKdNS4hQEh42vl5c1emvXmviSfBI0iBZCVh9zgwgaz7oCMh8leANnE
         CRZPiVHR5Pg0XNY2u38Mo2N5xSTC1wRBsfzOQ+ZFZDjGLK/B68jbV1GWVGJQ+olqWWxn
         +LcAhfdZEdmFtyXOA50AT4ZYzli9WJi4mc6ZCVVxDzP4WaIFF9B/9vumg80UAj/FQySW
         +aTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IiYBUrLnAPnSzUH+5luFf4rsxd6j3SEXozYrQ1VG+Vs=;
        b=T8G1aGsAahtG1xD5F0mvoexahBQZqPL3XH3+pR4A2AqNKHfIHHinhSXt7xBJZT7B6d
         z2YW6V6SGJu+XmbiySv1y4CoHgoG6TO0iu9m4dvDSlNZYwQ5xuiFs0gY5fnZvngS7FdX
         m1eTqlxWq7a1ISuzgnhv9jtR7Y8G7ZYHx7a+BKdYT+tS/+SANrim+CCdDwOHXfsQAsnc
         +RaXMNdLoRSNmMX1oZrJwtiOYv/NQTqjlQcMpHsr51e0vFgQ42neIgtfDPzkE7iWUT00
         RsETploRHuTyoftw4PPLcxmHIGg0hpfKGeyEhT/Qq7i42AgKG05i3Hcdkn6wjU6PtLdJ
         Z9OQ==
X-Gm-Message-State: ANoB5plGEWxKZjMeL/PVTqhcYQltwHK1gla30Orq6xRly2nlGyah8+Q6
        ZB3r+88/VtXB85r8qEJbYP1DQzD8dVYFfyPAE8MieQ==
X-Google-Smtp-Source: AA0mqf6BOMhYk9IL/Kor3xFlAIKpxSvscdAp0X2MXHJH3SI4JhdnrK56lS0AOpB2tLS0XU7CLGYkV5LUZb7vaKevn3c=
X-Received: by 2002:a67:be0c:0:b0:3aa:a89:3168 with SMTP id
 x12-20020a67be0c000000b003aa0a893168mr74170vsq.31.1668141691018; Thu, 10 Nov
 2022 20:41:31 -0800 (PST)
MIME-Version: 1.0
References: <20221103200359.328736-1-mathieu.desnoyers@efficios.com> <20221103200359.328736-9-mathieu.desnoyers@efficios.com>
In-Reply-To: <20221103200359.328736-9-mathieu.desnoyers@efficios.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Thu, 10 Nov 2022 20:41:07 -0800
Message-ID: <CALCETrW1doHX3=za+KDuB=4y+wHsnaZpVkDP3OhZXGrQU2iffw@mail.gmail.com>
Subject: Re: [PATCH v5 08/24] sched: Introduce per memory space current
 virtual cpu id
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@aculab.com,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Chris Kennelly <ckennelly@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Nov 3, 2022 at 1:05 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> This feature allows the scheduler to expose a current virtual cpu id
> to user-space. This virtual cpu id is within the possible cpus range,
> and is temporarily (and uniquely) assigned while threads are actively
> running within a memory space. If a memory space has fewer threads than
> cores, or is limited to run on few cores concurrently through sched
> affinity or cgroup cpusets, the virtual cpu ids will be values close
> to 0, thus allowing efficient use of user-space memory for per-cpu
> data structures.
>

Just to check, is a "memory space" an mm?  I've heard these called
"mms" or sometimes (mostly accurately) "processes" but never memory
spaces.  Although I guess the clone(2) manpage says "memory space".

Also, in my mind "virtual cpu" is vCPU, which this isn't.  Maybe
"compacted cpu" or something?  It's a strange sort of concept.
