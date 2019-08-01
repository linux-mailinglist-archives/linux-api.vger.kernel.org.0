Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F17F97D4E0
	for <lists+linux-api@lfdr.de>; Thu,  1 Aug 2019 07:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbfHAFaB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 1 Aug 2019 01:30:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:44126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbfHAFaB (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 1 Aug 2019 01:30:01 -0400
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85BB42171F
        for <linux-api@vger.kernel.org>; Thu,  1 Aug 2019 05:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564637400;
        bh=FqipvXd82HolAbu3Pa+FA938ekh3l6I5gKhcjjB/BwM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Jx6RZccjJHNTzNL0rmtTKYuTWKFJ8GMYn+aR4a60yYudI5eoXYncY6pFp8fWp/Tgb
         ANczfA6ETltNaj03O3S7+/vO/vR4fp6/GBcBKN2cXEUHiVukjqbidBesu90rsbdVkr
         t6idfeo5xY5D/cP/h7l1qu4FTcupZzHeGxHvyyXg=
Received: by mail-wm1-f53.google.com with SMTP id s15so40562210wmj.3
        for <linux-api@vger.kernel.org>; Wed, 31 Jul 2019 22:30:00 -0700 (PDT)
X-Gm-Message-State: APjAAAUlPLgXcgjTQOjcfrbD2IY14SEeOAkGcPsMhfvL8hP532wm2x8D
        5XX1m77CF24pnVst3FfZnMh9YgzAiQ5J50Lmcb5lkg==
X-Google-Smtp-Source: APXvYqwqyyhl/YzClxHO3xu5wRMyrUtVRl6n7dkFS6nFyiKVwQJibI/OsNXt3XS6gOCqjj8j69Enu8cxseortGZ/E50=
X-Received: by 2002:a1c:9a53:: with SMTP id c80mr52974634wme.173.1564637397150;
 Wed, 31 Jul 2019 22:29:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190729215758.28405-1-dima@arista.com> <20190729215758.28405-2-dima@arista.com>
In-Reply-To: <20190729215758.28405-2-dima@arista.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 31 Jul 2019 22:29:45 -0700
X-Gmail-Original-Message-ID: <CALCETrWHEcaG9gZe6ACt5H1H+P8D0RobrJ_bf4Wf9ts40NMM9w@mail.gmail.com>
Message-ID: <CALCETrWHEcaG9gZe6ACt5H1H+P8D0RobrJ_bf4Wf9ts40NMM9w@mail.gmail.com>
Subject: Re: [PATCHv5 01/37] ns: Introduce Time Namespace
To:     Dmitry Safonov <dima@arista.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@openvz.org>,
        Adrian Reber <adrian@lisas.de>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        criu@openvz.org, Linux API <linux-api@vger.kernel.org>,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jul 29, 2019 at 2:58 PM Dmitry Safonov <dima@arista.com> wrote:
>
> From: Andrei Vagin <avagin@openvz.org>
>
> Time Namespace isolates clock values.

> +static int timens_install(struct nsproxy *nsproxy, struct ns_common *new)
> +{
> +       struct time_namespace *ns = to_time_ns(new);
> +
> +       if (!thread_group_empty(current))
> +               return -EINVAL;

You also need to check for other users of the mm.

> +
> +       if (!ns_capable(ns->user_ns, CAP_SYS_ADMIN) ||
> +           !ns_capable(current_user_ns(), CAP_SYS_ADMIN))
> +               return -EPERM;
> +
> +       get_time_ns(ns);
> +       get_time_ns(ns);
> +       put_time_ns(nsproxy->time_ns);
> +       put_time_ns(nsproxy->time_ns_for_children);
> +       nsproxy->time_ns = ns;
> +       nsproxy->time_ns_for_children = ns;
> +       ns->initialized = true;

I really really wish that setns() took an explicit flag for "change
now" or "change for children", since the semantics are different.  Oh
well.
