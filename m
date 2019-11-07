Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A983F353A
	for <lists+linux-api@lfdr.de>; Thu,  7 Nov 2019 17:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729509AbfKGQ75 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 7 Nov 2019 11:59:57 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45408 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728847AbfKGQ75 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 7 Nov 2019 11:59:57 -0500
Received: by mail-lf1-f68.google.com with SMTP id v8so2128566lfa.12
        for <linux-api@vger.kernel.org>; Thu, 07 Nov 2019 08:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QmbLva0bcejWfZ5vroXCCCNjtDh9+KzeuzRfAkUcNVw=;
        b=RC+2jxnet1c9HEhXNBxtTTpEfLinckdbFJn5Bmrik3m/W7Num2OjpLxTQS23AoRNRr
         Aj4dYDnclnksK9me7oG5iyDsfchGPA4TwVOyMbOGN2PJFpJroPg+VNW7luk63nWV0aoz
         X/nFl5ue/aQhw5K+6Ogz8TNi8yWG86H2/HKz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QmbLva0bcejWfZ5vroXCCCNjtDh9+KzeuzRfAkUcNVw=;
        b=kxjeOShU+Aa1aJ/dmvoiTQDKvrLPCm/FDb+CN8HhnzkWqDcDAFH3VrtHFKtEG92t7w
         NSyNdc5sELa6Pzh2tpg1U2VIyzRqmmp9uia1H7AXyCJLpY+K0JR1LrDwb9cmH9HDPXqg
         ZxcWGhgm4IwaRqr7Tg8lDB1D0VP3UfMCRt66ecMrj/nfbjE52gkXw22iKH8K68N5iJ5A
         a+cPRm+ocNuL/+rLVXFVwIhyWW1Z5KaaAFx5DpOZPR00+Vbvq7GBkOkZgd4lrPvusLAg
         S1sq6gCxblHRNsZ5/fykzOLmcwR2O+PIiKuxAgJyc4br5Z0VJWKcEIKL23StcRfVt/V4
         nsnw==
X-Gm-Message-State: APjAAAUurw9ShWFZvvlVxSICMB9mHeRS3+TioqtHeitcsaE/abB247ed
        ylPH/+AG+rnB5LU61n+AbYH/Oy5+vyU=
X-Google-Smtp-Source: APXvYqzqP1bvF+unoC6elP+FwCJeMHOx6GRpNFaUtrD45qScSQXFoUiL5yix0la+w/vi0QWGNcw73g==
X-Received: by 2002:ac2:4ac1:: with SMTP id m1mr3119423lfp.182.1573145995108;
        Thu, 07 Nov 2019 08:59:55 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id j23sm1318164lji.41.2019.11.07.08.59.54
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2019 08:59:54 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id 195so2144140lfj.6
        for <linux-api@vger.kernel.org>; Thu, 07 Nov 2019 08:59:54 -0800 (PST)
X-Received: by 2002:ac2:5bca:: with SMTP id u10mr3159115lfn.134.1573145526683;
 Thu, 07 Nov 2019 08:52:06 -0800 (PST)
MIME-Version: 1.0
References: <157262967752.13142.696874122947836210.stgit@warthog.procyon.org.uk>
 <20191107090306.GV29418@shao2-debian>
In-Reply-To: <20191107090306.GV29418@shao2-debian>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 7 Nov 2019 08:51:50 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiJ+jaT5Ev-wCg7iGNNO_JFUyMDcat0KDdA2b_+n_cZCQ@mail.gmail.com>
Message-ID: <CAHk-=wiJ+jaT5Ev-wCg7iGNNO_JFUyMDcat0KDdA2b_+n_cZCQ@mail.gmail.com>
Subject: Re: [pipe] d60337eff1: phoronix-test-suite.noise-level.0.activity_level
 144.0% improvement
To:     lkp report check <rong.a.chen@intel.com>
Cc:     David Howells <dhowells@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Nov 7, 2019 at 1:03 AM lkp report check <rong.a.chen@intel.com> wrote:
>
> FYI, we noticed a 144.0% improvement of phoronix-test-suite.noise-level.0.activity_level due to commit:
>
> commit: d60337eff18a3c587832ab8053a567f1da9710d2 ("[RFC PATCH 04/11] pipe: Use head and tail pointers for the ring, not cursor and length [ver #3]")

That sounds nice, but is odd. That commit really shouldn't change
anything noticeable. David, any idea?

               Linus
