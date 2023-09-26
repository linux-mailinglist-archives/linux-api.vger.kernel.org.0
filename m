Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2F27AF781
	for <lists+linux-api@lfdr.de>; Wed, 27 Sep 2023 02:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbjI0AoO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 26 Sep 2023 20:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233236AbjI0AmN (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 26 Sep 2023 20:42:13 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DE51BB92
        for <linux-api@vger.kernel.org>; Tue, 26 Sep 2023 16:54:50 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50348c54439so1044e87.1
        for <linux-api@vger.kernel.org>; Tue, 26 Sep 2023 16:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695772489; x=1696377289; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DgrFSr0lcpMkghymDey2Le+WO5HSrc8DDvJYmyktvLM=;
        b=l6PGGprEC5xekYzZ2wvZt9t1/kGZxQEYiFDtliUb5iq9QT7BdhSTMXJhN711yyb+0S
         sacQ1MplBlfYnj8zlh6BJPAAimWzyA6wqR3oYYpz1Yt8ETERoPiTUk1Sr7VmSpHTu6GC
         Of4mXAxNeiKojccf4JLwpR/l9uyttFA1O5VmJIi6dnjy39DsK6i8pjeabD7USGT43BpR
         5PhGWjbEZpRPgNPYCKuNU0hG37b2EQel0trqxfUPxPGsDq/O+ZijydBh/xa5ahlPmQkm
         y0RKyHdMey1ufAhePm0+x2FHtrwslnzi2LKngkk3gxGYQNTCx2V3bVsP4lesSrQpbp6V
         RJhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695772489; x=1696377289;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DgrFSr0lcpMkghymDey2Le+WO5HSrc8DDvJYmyktvLM=;
        b=SFurZUG1ZHVltdN0HYGeeaLgS7uGqpaYkmSGy80xL5uhDKY7nvbaFYUwBpGEJrrdzB
         165QPocT4H865NW556rjmxE4kUkKiU69tyBWEAu16FmC6FEs0uJarxb2NsUIs4itsQs7
         VmIzkmPjE2Xw47xEJY8pZSvOPopMdg67LkSqbras0cRn4aIJ8w/6W7YoN3vrl60E7uKg
         TzD1QzVeAWGVZN6NMDmzrWvXyU8mbw5yNbrIPr9muLsgpmwOoM8mC5qeBfMoHUf9n84V
         zeBqs4PZZcTsB5ONLzZfYUNZ1EJligxsQ0z72AQ5DmQ0NRD82OktnnN4AL8/0QQI5HAK
         uThA==
X-Gm-Message-State: AOJu0Yz9EpSPHjjP2PVF36nyhix6BCZH6c3OD1yUtJ28jYV70aJAdpy4
        3uOgMlHXGZI1E0qKymu/Jw/Uv1HNVk8FCEsBKOKVng==
X-Google-Smtp-Source: AGHT+IEwPEUTHesOA8CXADgGak3kYxBneBIHCY/B7MbauZW/qvFRxs2BfhXQxx2fpaRGK29BAzR6CxsK6NG+SMUgl5k=
X-Received: by 2002:ac2:5299:0:b0:500:d960:1a75 with SMTP id
 q25-20020ac25299000000b00500d9601a75mr95687lfm.6.1695772488689; Tue, 26 Sep
 2023 16:54:48 -0700 (PDT)
MIME-Version: 1.0
References: <2c421e36-a749-7dc3-3562-7a8cf256df3c@efficios.com>
 <20230926205215.472650-1-dvyukov@google.com> <CACT4Y+beLh1qnHF9bxhMUcva8KyuvZs7Mg_31SGK5xSoR=3m1A@mail.gmail.com>
In-Reply-To: <CACT4Y+beLh1qnHF9bxhMUcva8KyuvZs7Mg_31SGK5xSoR=3m1A@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 26 Sep 2023 16:54:36 -0700
Message-ID: <CACT4Y+bSP3jnyb+AJSmbRk3pvwKc87t+uocErXOPYf_7uQ8YDg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/4] rseq: Add sched_state field to struct rseq
To:     mathieu.desnoyers@efficios.com
Cc:     David.Laight@aculab.com, alexander@mihalicyn.com,
        andrealmeid@igalia.com, boqun.feng@gmail.com, brauner@kernel.org,
        carlos@redhat.com, ckennelly@google.com, corbet@lwn.net,
        dave@stgolabs.net, dvhart@infradead.org, fweimer@redhat.com,
        goldstein.w.n@gmail.com, hpa@zytor.com, libc-alpha@sourceware.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        longman@redhat.com, mingo@redhat.com, paulmck@kernel.org,
        peterz@infradead.org, pjt@google.com, posk@posk.io,
        rostedt@goodmis.org, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

> +void __rseq_set_sched_state(struct task_struct *t, unsigned int state)
> +{
> + if (unlikely(t->flags & PF_EXITING))
> + return;

Don't we want to do this even if the task is exciting?
If rseq is read only only the current task, then it does not matter
(exiting task won't read own rseq anymore). But if we extending
expected uses cases to tasks reading rseq of other tasks, we may need
to updates even in PF_EXITING case.

> + pagefault_disable();

This is a bit concerning. Does this mean updates are not done if the
page is currently not in memory? Can we make it reliable as for the
main rseq data (cpu_id)?
For tcmalloc uses (and other uses that require reliable information)
this may be problematic. User-space may start thinking that all "CPU
slots" are busy and that there more threads running than there are
CPUs.

> + (void) put_user(state, &t->rseq_sched_state->state);
> + pagefault_enable();
> +}
