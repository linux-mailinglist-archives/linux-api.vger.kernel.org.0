Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2528BE0683
	for <lists+linux-api@lfdr.de>; Tue, 22 Oct 2019 16:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbfJVOfH (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 22 Oct 2019 10:35:07 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34850 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfJVOfH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 22 Oct 2019 10:35:07 -0400
Received: by mail-lj1-f193.google.com with SMTP id m7so17482271lji.2
        for <linux-api@vger.kernel.org>; Tue, 22 Oct 2019 07:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BYDYFcrmZnPsA3wNhTxT7xGFYYOAAOh9Vy6atnzjLi0=;
        b=waU2hpheX/TrBzV4vEgbgCSQZavQHRKBJyf3We9Oa6EO8pqIzKn/x0RR8yVxAJtXif
         o5wV6xEZj6OmkN+gsNlUIE3SlrYWpP6FnQR91Mkel7Yc31DCKJCqxLVac9zBJWfrqAig
         AnSHfrBGwdsobSt4I2ex8H13Pw5VSILZpZP+0W9/3gOphmAg2NFATMuQ5R5i0fTwxMHa
         mhvxoAYbxgHGF854kilNFHJ9Ees7EW7wGZpA08bLcn+TV5//6T+8yvwOpxDYnmTocS9P
         uzp8bmCNZ414ELtk0X90GazUNbo+1P3jEAIUYD/1uT+dLLXF/88QLkWvgCN4cSI9DcT+
         xtYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BYDYFcrmZnPsA3wNhTxT7xGFYYOAAOh9Vy6atnzjLi0=;
        b=htt8T6V78eBuyWmPQIeD1uJWDR0VBhDLPFiW5Gp3/k9mPaCg2k4gXakW8CFgaq1yQe
         0/wqeZr45t8YG4Kpai05CqX8J44krXwqB1K/7qTssJnARZsfbDd6J30u4wQ+25oaMU+i
         KdsbN+Jzf2GP1qpiYw4ZhUedk4Cc9KZlWvRB5G1enHN14+ZAVNstDgak1ahoCijTzsry
         /Ryb0/4Ej12KQGLY2MrrvnxvJlxjndtprr2TzKXUw0nn9IgxY+AXeA2wdVhW1eLVdQTo
         kF3hc36Siuen4IWMeAIGn7nFI24gU39c6/1pA8cRqVrbBglioodWNA1VkmmTlbfNSkxW
         bZxg==
X-Gm-Message-State: APjAAAVSp+TKr8ojEdIWoPSqnlEG3zkHhjl6HHk5OBYT01ZAgbcC+F0L
        ChA+2U6nP9kyST7A+l2+Kkr7yhMSflrXge7mJA3y
X-Google-Smtp-Source: APXvYqxWl+VJRD6qwDm3xnMIjUjL7khHepxMxomEkV8ULQEiUK2eWkxiHdieTFB5R0wrN5wi4Wq/lLVlZuZfm59x+Po=
X-Received: by 2002:a2e:3505:: with SMTP id z5mr11579413ljz.126.1571754905226;
 Tue, 22 Oct 2019 07:35:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568834524.git.rgb@redhat.com> <214163d11a75126f610bcedfad67a4d89575dc77.1568834525.git.rgb@redhat.com>
 <20191019013904.uevmrzbmztsbhpnh@madcap2.tricolour.ca> <CAHC9VhRPygA=LsHLUqv+K=ouAiPFJ6fb2_As=OT-_zB7kGc_aQ@mail.gmail.com>
 <20191021213824.6zti5ndxu7sqs772@madcap2.tricolour.ca> <CAHC9VhRdNXsY4neJpSoNyJoAVEoiEc2oW5kSscF99tjmoQAxFA@mail.gmail.com>
 <20191021235734.mgcjotdqoe73e4ha@madcap2.tricolour.ca> <CAHC9VhSiwnY-+2awxvGeO4a0NgfVkOPd8fzzBVujp=HtjskTuQ@mail.gmail.com>
 <20191022142716.sgxcmc27w4uaqh3u@madcap2.tricolour.ca>
In-Reply-To: <20191022142716.sgxcmc27w4uaqh3u@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 22 Oct 2019 10:34:54 -0400
Message-ID: <CAHC9VhQwXzyZzrN3fcc=OOqJPu+=CrkWUWGWjKNzP5OPVT_0_g@mail.gmail.com>
Subject: Re: [PATCH ghak90 V7 20/21] audit: add capcontid to set contid
 outside init_user_ns
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        sgrubb@redhat.com, omosnace@redhat.com, dhowells@redhat.com,
        simo@redhat.com, Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>, ebiederm@xmission.com,
        nhorman@tuxdriver.com, Dan Walsh <dwalsh@redhat.com>,
        mpatel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Oct 22, 2019 at 10:27 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> I'd like your perspective on how the capcontid feature was implemented
> (aside from the proc/netlink api issue which was intended to be
> consistent across loginuid/sessionid/contid/capcontid).  Do you see this
> feature as potentially solving the nested container issue in child user
> namespaces?

The patchset is a bit messy at this point in the stack due to the
"fixup!" confusion and a few other things which I already mentioned so
I don't really want to comment too much on that until I can see
everything in a reasonable patch stack.  Let's leave that for the next
draft.

-- 
paul moore
www.paul-moore.com
