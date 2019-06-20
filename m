Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3AA84D294
	for <lists+linux-api@lfdr.de>; Thu, 20 Jun 2019 17:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfFTP5W (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 Jun 2019 11:57:22 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42290 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfFTP5W (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 Jun 2019 11:57:22 -0400
Received: by mail-lj1-f196.google.com with SMTP id t28so3175222lje.9
        for <linux-api@vger.kernel.org>; Thu, 20 Jun 2019 08:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jWGyLei7iIX0YquCcpJVdvUVmyD9HHcydfLdWLV6VdQ=;
        b=bFe5M5Viz6mhTHKLXiMPTsQHKWSneXU/P32CqJMYYaptrO+yxI3A5ZHrwgrV2u0KS5
         rMgI+Roe2+x3nxcZJ1pksI2BGPwWFMRIupONO1kQiB3020Q2Rgino0w1y37GLCitolpZ
         audrqCWFZ8YkyqtOjHihYhu0nEmriemTSSrqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jWGyLei7iIX0YquCcpJVdvUVmyD9HHcydfLdWLV6VdQ=;
        b=m9Jvd4XAQYK1Ih1tJ/B/DhqjZQ/AuyUaxxwkTbOAbQKplw6qGkLPUBx+pIVE6Yln1A
         JOwOHmD34e2n2ZP55oZlhBDvL3JWvO891ocjtiSWel5Z/OKHj99lZ2v4T6frECnCBe1i
         EfJ62mfq9ciIobxzimUsRROsI0EKvMtwjK16+WQPH0j4JyKTmCg1Ecx4iHd9DbAILeOL
         zyfJAX9acQpteVqjMTHpk/l537ITo3LQ/cTaNosX07Udicn4oVBG6JuEH1TLIa24kDEe
         Ufm3aKc8HFHHxzKmGBCzjz5648MnvZsH2y3FEm4cLQXnWKGa/7S5dzOVSD8Sipj1NXPG
         E+Pw==
X-Gm-Message-State: APjAAAX/VEcD/R+5pRuVYfdqOPAx3JGbAP0Yx6VdfKlpqh5uUx7Xvclb
        tLhIqjUTLro6+iuHiS5/9M11PljOK7NC6ACsMUwCWA==
X-Google-Smtp-Source: APXvYqwrlNR3lH/4m9IeD5Bkl0pzlV3Ska/rPfDDBMmGCP6oxktUzG4DNWPlJ52+fxSnzyurONehOvGDKpiTNUq3KkQ=
X-Received: by 2002:a2e:3602:: with SMTP id d2mr7778406lja.112.1561046240877;
 Thu, 20 Jun 2019 08:57:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190603053655.127730-1-minchan@kernel.org> <20190603053655.127730-2-minchan@kernel.org>
 <20190604203841.GC228607@google.com> <20190610100904.GC55602@google.com>
 <20190612172104.GA125771@google.com> <20190613044824.GF55602@google.com>
 <20190619171340.GA83620@google.com> <20190620050132.GC105727@google.com>
In-Reply-To: <20190620050132.GC105727@google.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 20 Jun 2019 11:57:09 -0400
Message-ID: <CAEXW_YSY2GgW_Fp6VN2Qrf0Gr8c71DUgoTzZoq-V2=jFgDEDvQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] mm: introduce MADV_COLD
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Christian Brauner <christian@brauner.io>, oleksandr@redhat.com,
        hdanton@sina.com, Vladimir Davydov <vdavydov.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jun 20, 2019 at 1:01 AM Minchan Kim <minchan@kernel.org> wrote:
[snip]
> > > >
> > > > I think to fix this, what you should do is clear the PG_Idle flag if the
> > > > young/accessed PTE bits are set. If PG_Idle is already cleared, then you
> > > > don't need to do anything.
> > >
> > > I'm not sure. What does it make MADV_COLD special?
> > > How about MADV_FREE|MADV_DONTNEED?
> > > Why don't they clear PG_Idle if pte was young at tearing down pte?
> >
> > Good point, so it sounds like those (MADV_FREE|MADV_DONTNEED) also need to be fixed then?
>
> Not sure. If you want it, maybe you need to fix every pte clearing and pte_mkold
> part, which is more general to cover every sites like munmap, get_user_pages and
> so on. Anyway, I don't think it's related to this patchset.

Ok, I can look into this issue on my own when I get time. I'll add it
to my list. No problems with your patch otherwise from my side.

 -Joel
