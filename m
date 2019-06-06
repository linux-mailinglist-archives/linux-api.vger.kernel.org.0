Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB48B37D4A
	for <lists+linux-api@lfdr.de>; Thu,  6 Jun 2019 21:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfFFTeP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 6 Jun 2019 15:34:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:55066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726626AbfFFTeO (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 6 Jun 2019 15:34:14 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5B3F20B1F
        for <linux-api@vger.kernel.org>; Thu,  6 Jun 2019 19:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559849654;
        bh=Bp9xchL8n3xgevCioLqnZ63AUKcEYYQAzSzsygrBl6U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HO604baqNXqdV732MJGVIuAhse5+ZFoSM5Cc0+2Fn/Ht+x4OWlMx5PGxpQjuhnWoS
         +5SGAibaql+Dy5Y2lXYd+TCXM2PP/XUh2keaEDA+zVknERXfBQhrqM5U8gIKyqt0mE
         /xX8R4yDLByF0tIfKTWY8lYeF4L8I6C1xdq0ZN7E=
Received: by mail-wr1-f46.google.com with SMTP id m3so3639373wrv.2
        for <linux-api@vger.kernel.org>; Thu, 06 Jun 2019 12:34:13 -0700 (PDT)
X-Gm-Message-State: APjAAAU739W2VVB39cSJxGfeZFLY1vp6xYUYWpHv4QjYU5jCKctW25Vg
        SQF6gs03aV2TaT8AGP8YdXpKkHSYRYoL7FYtVPVZHQ==
X-Google-Smtp-Source: APXvYqyO0ntp0Z78do7NHqcK5WkwMIKd2ggjzZIlWltFYH5IsItDZMYnUyFRT0pbmOUPFNCMQaXV3mrI0CbuFbD87wc=
X-Received: by 2002:adf:ef48:: with SMTP id c8mr9349668wrp.352.1559849652241;
 Thu, 06 Jun 2019 12:34:12 -0700 (PDT)
MIME-Version: 1.0
References: <155981411940.17513.7137844619951358374.stgit@warthog.procyon.org.uk>
 <155981413016.17513.10540579988392555403.stgit@warthog.procyon.org.uk>
 <176F8189-3BE9-4B8C-A4D5-8915436338FB@amacapital.net> <11031.1559833574@warthog.procyon.org.uk>
 <CALCETrUukxNNhbBAifxz1EADzLOvYKoh9oqqZFJteU+MMhh1ig@mail.gmail.com> <e434a62a-d92a-c6e2-cda1-309ac99d4d5c@schaufler-ca.com>
In-Reply-To: <e434a62a-d92a-c6e2-cda1-309ac99d4d5c@schaufler-ca.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 6 Jun 2019 12:34:00 -0700
X-Gmail-Original-Message-ID: <CALCETrVc=PpCjSC-pjcjr0WMKtgVXWijwB3FX+tSp5VOH2bCpg@mail.gmail.com>
Message-ID: <CALCETrVc=PpCjSC-pjcjr0WMKtgVXWijwB3FX+tSp5VOH2bCpg@mail.gmail.com>
Subject: Re: [PATCH 01/10] security: Override creds in __fput() with last
 fputter's creds [ver #3]
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, raven@themaw.net,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jun 6, 2019 at 12:09 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 6/6/2019 10:18 AM, Andy Lutomirski wrote:
> > On Thu, Jun 6, 2019 at 8:06 AM David Howells <dhowells@redhat.com> wrote:
> >> Andy Lutomirski <luto@amacapital.net> wrote:

> > Casey, I think you need to state your requirement in a way that's well
> > defined, and I think you need to make a compelling case that your
> > requirement is indeed worth dictating the design of parts of the
> > kernel outside LSM.
>
> Err, no, I don't believe so. There's a whole lot more
> going on in this discussion than just what's going on
> within the LSMs. Using examples from the LSMs makes it
> easier, because their policies are better defined than
> the "legacy" policies are. The most important part of the
> discussion is about ensuring that the event mechanism
> doesn't circumvent the legacy policies. Yes, I understand
> that you don't know what that means, or has to do with
> anything.
>
>

Indeed, I do not know what you have in mind about making sure this
mechanism doesn't circumvent legacy policies.  Can you elaborate?

--Andy
