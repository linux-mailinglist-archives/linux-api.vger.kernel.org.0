Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A96A6115A8D
	for <lists+linux-api@lfdr.de>; Sat,  7 Dec 2019 02:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfLGBLY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 6 Dec 2019 20:11:24 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41708 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfLGBLY (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 6 Dec 2019 20:11:24 -0500
Received: by mail-lf1-f65.google.com with SMTP id m30so6596232lfp.8
        for <linux-api@vger.kernel.org>; Fri, 06 Dec 2019 17:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xp39wpo5AR+pbRP/tZoeRSZICS3SHzWRMfhJEvbxIGA=;
        b=F9QgFlzOLVDvV/NH9kO5C38Tw6X+Hr1zV9nvDrPtaW9IdmdHU1TNQTmWgtmr08QLWs
         m/LzPoUZk/NRRXSGyCni67pyjPAjI1csctIc4AcmS9vEoOX/8bco5LDaWzkI+5Pvvxsm
         tA5h/kF2wpsxbPSmFh84K3eYpHR4dbqT6qkZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xp39wpo5AR+pbRP/tZoeRSZICS3SHzWRMfhJEvbxIGA=;
        b=j+dMHbnM/ObKG0GdX+GMNbNnWiGk+875sfn0Ra94KgkNhp/K8J9CyMxHaWuNU+Mlnt
         +VaGbeIz6lqNEUFGJnMMqJUDv02p5SrIQxxHr4xeGdqRRHR55QhHJpLFWRODYtv9vLrZ
         EsN3VELIHFPbY9YPUhCwwxB3GJATStLzTdF/0DVCqbnWFpJzFX33DQK3HcW9UqHlUvRU
         ZFHacnRF9vmg9i8Iwwat3Fz3s270bvlOCRn2r8hpxbwg90crmjZbWWawrXXl+UivXX/4
         +bqRvcMKDwXs+8c6IPgJ0v9aaaF7Teuui81GexuvBuIhrstqUism3dEIdJS44p4kiuNH
         4dMw==
X-Gm-Message-State: APjAAAVs3yLxKoMsxQapDna+L3lk6gl2F0KKsiuDcZkeQSON5UmwmVTe
        9/OqozDRp8tgpjQvh7OmFi3altp2Ng8=
X-Google-Smtp-Source: APXvYqy4CWdnWNyCOCD+DDSF4nUXcbUz3NMEMfszjzIOpj94ZBUCBSBCEsekg5bXt2XnZxCQl/nYqw==
X-Received: by 2002:a19:be93:: with SMTP id o141mr5795138lff.181.1575681082341;
        Fri, 06 Dec 2019 17:11:22 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id x23sm7339046lff.24.2019.12.06.17.11.21
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2019 17:11:22 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id y19so6580629lfl.9
        for <linux-api@vger.kernel.org>; Fri, 06 Dec 2019 17:11:21 -0800 (PST)
X-Received: by 2002:ac2:555c:: with SMTP id l28mr9400181lfk.52.1575680636244;
 Fri, 06 Dec 2019 17:03:56 -0800 (PST)
MIME-Version: 1.0
References: <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk>
 <157186186167.3995.7568100174393739543.stgit@warthog.procyon.org.uk>
 <20191206214725.GA2108@latitude> <CAHk-=wga0MPEH5hsesi4Cy+fgaaKENMYpbg2kK8UA0qE3iupgw@mail.gmail.com>
 <20191207000015.GA1757@latitude>
In-Reply-To: <20191207000015.GA1757@latitude>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 6 Dec 2019 17:03:40 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjEa5oNcQ9+9fai1Awqktf+hzz_HZmChi8HZJWcL62+Cw@mail.gmail.com>
Message-ID: <CAHk-=wjEa5oNcQ9+9fai1Awqktf+hzz_HZmChi8HZJWcL62+Cw@mail.gmail.com>
Subject: Re: [RFC PATCH 04/10] pipe: Use head and tail pointers for the ring,
 not cursor and length [ver #2]
To:     Johannes Hirte <johannes.hirte@datenkhaos.de>
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Dec 6, 2019 at 4:00 PM Johannes Hirte
<johannes.hirte@datenkhaos.de> wrote:
>
> Tested with 5.4.0-11505-g347f56fb3890 and still the same wrong behavior.

Ok, we'll continue looking.

That said, your version string is strange.

Commit 347f56fb3890 should be  "v5.4.0-13174-g347f56fb3890", the fact
that you have "11505" confuses me.

The hash is what matters, but I wonder what is going on that you have
the commit count in that version string so wrong.

                   Linus
