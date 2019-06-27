Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9EA58E64
	for <lists+linux-api@lfdr.de>; Fri, 28 Jun 2019 01:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfF0XQu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 27 Jun 2019 19:16:50 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34962 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfF0XQu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 27 Jun 2019 19:16:50 -0400
Received: by mail-io1-f68.google.com with SMTP id m24so8587669ioo.2
        for <linux-api@vger.kernel.org>; Thu, 27 Jun 2019 16:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l09Vp/UFzjV2DgL5GelYaPoe+l0vquG8kvrDE5UvKZ4=;
        b=p+RXdIQ9LdOUo9HMqEjolw7nVtxtU9esOCN/xbbHp1vRG8hYQOlh+KveY/OvRL2Dk7
         /Sgzz0KeR4Q8yEuZM0OMJsjc+IHH6W0vlWIS3We0QKUMy4r+wXV5mzL2CMPPpLc7MU9E
         nihwmXvu6kxkmZt0zF2OFHwzLYMt8EvlDQloKxfK9UTQjiLCOEDnBHLWTpVh4ebm7DTR
         hDzQbz5nPxZ7KW9nhlq+/LEYTqO7mykeJsKaUKHQyCEvYsRyiOdQE8mlaeXkmO67/htL
         TDe4QO4KlswqnZf5MQ5sqfIuXUvKtpXkOiBvmW4yjA4YOlbbldqAB3GGpBkkLZGRuWDY
         Mefg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l09Vp/UFzjV2DgL5GelYaPoe+l0vquG8kvrDE5UvKZ4=;
        b=gyPMiHhi+FWMIyzU2nK2qlPt4/GLr7I+3eqxFAtYgP+RM0lPqiLv5cYD+6S0a/BcPq
         xsAqbSBPC9oFjoZTurwJ4Iot5lW1Eq+4gBe5PfGb0G6ba3IJusOTuLjMXeTgT0eTgq/S
         5Ov4hzm5XOM9GzxBVQ30lRX2+7FnBl7M2CsMTCzu6VejiFlCogbpgO+ClZm16/OjxtAQ
         Vx6Z/9Jlcrc3A/lbWb0VlFmhLHLUkaFGvNLOUT02P/cBScxgTK17dbbdYVRsqdznEL9E
         IGXSPRFzhb3srNVLb5HvOGu5bxsszk9V/LjECKv6fEMZt70hvTjECZo4/qNVTH/zQz1+
         aKTw==
X-Gm-Message-State: APjAAAW4YN6a4pxerw6RtRakqZLhXQtmUft3Q7+DLTfrQwabZwlXEQ+o
        7lbJVgHXp409ZFnhKi1zNO535uO4F7GfHcCFunsC6w==
X-Google-Smtp-Source: APXvYqwhWpwuqv8JIHwubX3lZlHutL4a69xEX/nsI5R2vEJeO+7JbyaxQ07hwkqSiA02QGSjTt+drzLx9imS1tYMhQw=
X-Received: by 2002:a02:ab99:: with SMTP id t25mr7575038jan.113.1561677408975;
 Thu, 27 Jun 2019 16:16:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190621011941.186255-1-matthewgarrett@google.com>
 <20190621011941.186255-25-matthewgarrett@google.com> <CALCETrVUwQP7roLnW6kFG80Cc5U6X_T6AW+BTAftLccYGp8+Ow@mail.gmail.com>
 <alpine.LRH.2.21.1906270621080.28132@namei.org> <6E53376F-01BB-4795-BC02-24F9CAE00001@amacapital.net>
 <bce70c8b-9efd-6362-d536-cfbbcf70b0b7@tycho.nsa.gov> <alpine.LRH.2.21.1906280332500.17363@namei.org>
 <de8b15eb-ba6c-847a-7435-42742203d4a5@tycho.nsa.gov>
In-Reply-To: <de8b15eb-ba6c-847a-7435-42742203d4a5@tycho.nsa.gov>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 27 Jun 2019 16:16:36 -0700
Message-ID: <CACdnJuuG8cR7h9v3pNcBKsxyckAzpKuBJs1GQxsz77jk5DRoQA@mail.gmail.com>
Subject: Re: [PATCH V33 24/30] bpf: Restrict bpf when kernel lockdown is in
 confidentiality mode
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     James Morris <jmorris@namei.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>,
        linux-security@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        Chun-Yi Lee <jlee@suse.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jun 27, 2019 at 1:16 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> That would only allow the LSM to further lock down the system above the
> lockdown level set at boot, not grant exemptions for specific
> functionality/interfaces required by the user or by a specific
> process/program. You'd have to boot with lockdown=none (or your
> lockdown=custom suggestion) in order for the LSM to allow anything
> covered by the integrity or confidentiality levels.  And then the kernel
> would be unprotected prior to full initialization of the LSM, including
> policy load.
>
> It seems like one would want to be able to boot with lockdown=integrity
> to protect the kernel initially, then switch over to allowing the LSM to
> selectively override it.

One option would be to allow modules to be "unstacked" at runtime, but
there's still something of a problem here - how do you ensure that
your userland can be trusted to load a new policy before it does so?
If you're able to assert that your early userland is trustworthy
(perhaps because it's in an initramfs that's part of your signed boot
payload), there's maybe an argument that most of the lockdown
integrity guarantees are unnecessary before handoff - just using the
lockdown LSM to protect against attacks via kernel parameters would be
sufficient.
