Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0F4CA6B33
	for <lists+linux-api@lfdr.de>; Tue,  3 Sep 2019 16:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbfICOWL (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 3 Sep 2019 10:22:11 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34636 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728994AbfICOWL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 3 Sep 2019 10:22:11 -0400
Received: by mail-qk1-f193.google.com with SMTP id q203so6875904qke.1
        for <linux-api@vger.kernel.org>; Tue, 03 Sep 2019 07:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zXvrHc8bIlM8VodivjNDsnx6+oAEFk8HI08Pi/PdZy0=;
        b=arZrudyLT8vTBXeGc+RzCc8cTYEs3iyuTYalOAK8Glv1IOK+eWWBNQWyvS8kFPmvs8
         cXIvmXi+hJkM1FOJpx5IPOjfYvPRIzhid3fb2nB/JrVWSTaqecT2VZSSzQiT3GLBEhVD
         smanZ/a5pgEUewoLHRsTzIMv9ved1r7kbjWXhXrjDyLyY7rPLZf0ySFrYu7mKpvQJxkF
         6zkSA2MEAIopfNY5Ll0n+vlI8Z1hVWLGrtAY/KyJTTp+EipIkSMRL9vg7B0zT/2F6vW+
         GLuEGCAkw1KhNkAUKZ5Qs8nmOqIqiZ993sMb4VYDVKWNLkoIjdzO2woNnmAnCXfVizng
         kRPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zXvrHc8bIlM8VodivjNDsnx6+oAEFk8HI08Pi/PdZy0=;
        b=JE0RabIFep4RcIvI6EGRzEa7Im95Gz3yyj5vUauMDW+cX6A+nNMoyXIa8Ki9c+LwF3
         uxoOgipCx2BGSRJ1+NpKa7ILtZY8YNAuAArQwJn8NhzLvhkEkboF7EQSQIedJMDN4Wgo
         j11D7HI/AkK+7eiAqrReEa1MEW4E0ptyrEM7YKpAvO4UgWWKwnlfkhGxuGh/vy7edag6
         0yIZAqwF9UiF8A3vrOwypnBEdEx76xYNM5hiV/riS1AbAgSHhsCihWT/iBG8+Ca7oVe4
         Rq5zNqx5B2DeJiHCwXGBOMiUH+ybA6FENmp4nGL+hp034K7T0KhyXppIOxVDMaHTz1Lm
         KHdg==
X-Gm-Message-State: APjAAAUmO6rhmLgX9PPDAV0aZGsaFYaaRFu9kC2ri4PgVKyEfkjUOYgO
        hh5mBpva7yTNdWjp8n7Y2OpUJIgchT6wbspCPRlCfQ==
X-Google-Smtp-Source: APXvYqzRj6Qy94zXxM718BMGrBx7jps9qVb8rKF7Cps40w/i6I9cXmMkiicMdflzzRvbKZLV3AfkOSAorVEoJeh+BqA=
X-Received: by 2002:a05:620a:1367:: with SMTP id d7mr12839832qkl.20.1567520530372;
 Tue, 03 Sep 2019 07:22:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190822132811.31294-1-patrick.bellasi@arm.com>
 <20190822132811.31294-2-patrick.bellasi@arm.com> <CAJuCfpGWtrg02LNE3PJZag9-LLVT=by2v+9x_tm1PyoXwZ8DqQ@mail.gmail.com>
 <20190903085248.GB8756@blackbody.suse.cz>
In-Reply-To: <20190903085248.GB8756@blackbody.suse.cz>
From:   Joel Fernandes <joelaf@google.com>
Date:   Tue, 3 Sep 2019 10:21:59 -0400
Message-ID: <CAJWu+opnNT3bQwe+SsdR0Q+PSt7DA=JAQ_5sbZ6h2DXd4ZqwHA@mail.gmail.com>
Subject: Re: [PATCH v14 1/6] sched/core: uclamp: Extend CPU's cgroup controller
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Alessio Balsini <balsini@android.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Paul Turner <pjt@google.com>,
        Steve Muckle <smuckle@google.com>,
        Todd Kjos <tkjos@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Tejun Heo <tj@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        linux-api@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Sep 3, 2019 at 4:53 AM Michal Koutn=C3=BD <mkoutny@suse.com> wrote:
>
> On Mon, Sep 02, 2019 at 04:02:57PM -0700, Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> > > +static inline void cpu_uclamp_print(struct seq_file *sf,
> > > +                                   enum uclamp_id clamp_id)
> > > [...]
> > > +       rcu_read_lock();
> > > +       tg =3D css_tg(seq_css(sf));
> > > +       util_clamp =3D tg->uclamp_req[clamp_id].value;
> > > +       rcu_read_unlock();
> > > +
> > > +       if (util_clamp =3D=3D SCHED_CAPACITY_SCALE) {
> > > +               seq_puts(sf, "max\n");
> > > +               return;
> > > +       }
> > > +
> > > +       percent =3D tg->uclamp_pct[clamp_id];
> >
> > You are taking RCU lock when accessing tg->uclamp_req but not when
> > accessing tg->uclamp_pct.
> Good point.
>
> > Is that intentional? Can tg be destroyed under you?
> Actually, the rcu_read{,un}lock should be unnecessary in the context of
> the kernfs file op handler -- the tg/css won't go away as long as its
> kernfs file is being worked with.
>

Also, add to that the fact that there is no rcu_dereference() call to
access any of the pointers in the reader or any of its callers. And, I
don't see any "wait for completion" type of pattern here so that
rcu_read_{lock, unlock}() pair does seem useless.

thanks,

 - Joel
