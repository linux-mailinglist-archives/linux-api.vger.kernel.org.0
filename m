Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB9A2A569E
	for <lists+linux-api@lfdr.de>; Tue,  3 Nov 2020 22:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733219AbgKCV3H (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 3 Nov 2020 16:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387979AbgKCV3E (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 3 Nov 2020 16:29:04 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3211C0617A6
        for <linux-api@vger.kernel.org>; Tue,  3 Nov 2020 13:29:03 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id c9so618497wml.5
        for <linux-api@vger.kernel.org>; Tue, 03 Nov 2020 13:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=coCVSzogN7FhufO26SBDPdyABYAN7DRvbWuTG3U17pI=;
        b=iugY1zHxj+rcoEypRyKobqPHp2mh1vGfJXqR12Xn7NjuNH1nJWgfMn2R9Vnetqh2gm
         biK82RCbDxhSsRJqM2JNMXFRHP7Q/f6H5OXNd1LF8QScpPd1dJWuyshd2FRZZyx/vWxM
         Bik3sNu0e+0j6yAyP+Q6lDYLfE6y8ro4eBGZXSEcQ51LDOTZ/I+6imS3zV10kdZtIW1K
         GykTfekQlxVHsmHkwb9UW0G80BB06wmmU8mvqe2BxzQECn6D4slUc2M7abwJGMwKKUsx
         /tsZbgQfH2/MLDidcnifIEMiCMDEQPoOhaYvh8AHffReKHVQEQRY/Wp77I0V3TF6bceH
         7pdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=coCVSzogN7FhufO26SBDPdyABYAN7DRvbWuTG3U17pI=;
        b=dTAd/n2Mx6nthExGvM++XVu1RQSJhTL+YRS7g2Cjp3LSRsDC1L5GORrovaJK26O51L
         E4W1BdOpD/kGZiuQ83Jpqtv+YTPaPu4Gg2ih5i0cxtxHChEevglQJsRoVNEJ3zJXs5Ka
         cnmyVlHHHKSEpaIgBMm3sYvYqAo6U+gckHDyUgbxoe4xiQSIclduMizNDA+oiDCSZU/9
         QJPcbfGTnv0/iu/e//wgzU1xpDIu59d+ICc2Ripv9gvnrHpNWDmSVXCb793z93T/+HTn
         KbxjTX9lnt1cKvr0Z7ChT14H2B3J5YvQ2VZt8WqiDn9gYcGegGO29gR4dKDOIf3RCru8
         lftQ==
X-Gm-Message-State: AOAM530AIbjio4//w8ZHYfl6+cZ467LOKozD+VWI6FT2jmivIKWUtPMD
        X0tk2UtIyO0BcX1IabWSdXhZ+34hWVN8yZclmUmFQQ==
X-Google-Smtp-Source: ABdhPJwjZHXUS+ZXtJZWnGUnzGmYa3rlxOLjOWvm9qm54qf9JdTinBsnwxtE8GcZ/WkZB9KXdiiMVPoCZKZAMvh9tOk=
X-Received: by 2002:a1c:1b85:: with SMTP id b127mr1167531wmb.163.1604438942285;
 Tue, 03 Nov 2020 13:29:02 -0800 (PST)
MIME-Version: 1.0
References: <CAJuCfpGz1kPM3G1gZH+09Z7aoWKg05QSAMMisJ7H5MdmRrRhNQ@mail.gmail.com>
 <CAJuCfpGjuUz5FPpR5iQ7oURJAhnP1ffBAnERuTUp9uPxQCRhDg@mail.gmail.com>
 <20201014120937.GC4440@dhcp22.suse.cz> <CAJuCfpEQ_ADYsMrF_zjfAeQ3d-FALSP+CeYsvgH2H1-FSoGGqg@mail.gmail.com>
 <20201015092030.GB22589@dhcp22.suse.cz> <CAJuCfpHwXcq1PfzHgqyYBR3N53TtV2WMt_Oubz0JZkvJHbFKGw@mail.gmail.com>
 <CAJuCfpH9iUt0cs1GBQppgdcD8chojCNXk22S+PeSgQ-bA7iitQ@mail.gmail.com> <20201103093550.GE21990@dhcp22.suse.cz>
In-Reply-To: <20201103093550.GE21990@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 3 Nov 2020 13:28:51 -0800
Message-ID: <CAJuCfpH4hdyMTdvSyY9uJgMQz-Gfff-ZgWisgx4TVUpq_F_sAw@mail.gmail.com>
Subject: Re: [RFC]: userspace memory reaping
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-api@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Oleg Nesterov <oleg@redhat.com>,
        Tim Murray <timmurray@google.com>,
        kernel-team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Nov 3, 2020 at 1:35 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 02-11-20 12:29:24, Suren Baghdasaryan wrote:
> [...]
> > To follow up on this. Should I post an RFC implementing SIGKILL_SYNC
> > which in addition to sending a kill signal would also reap the
> > victim's mm in the context of the caller? Maybe having some code will
> > get the discussion moving forward?
>
> Yeah, having a code, even preliminary, might help here. This definitely
> needs a good to go from process management people as that proper is land
> full of surprises...

Hmm. Adding a new SIGKILL_SYNC seems to require quite a surgery...
That will cause a change to SIGRTMIN which is used by glib and also
would affect RTSIG_MAX which I think is also used by the userspace.
I'm not sure such a change would be acceptable...

IIUC, Minchan's alternative suggestion was to do mm reaping from
inside fsync() in cases like these:

pidfd_send_signal(pidfd, SIGKILL); // send SIGKILL as usual
fsync(pidfd); // causes mm reaping in the context of the caller

I can prototype this approach quite easily and quickly and post an RFC
to energize the discussion. Any objections?

> --
> Michal Hocko
> SUSE Labs
