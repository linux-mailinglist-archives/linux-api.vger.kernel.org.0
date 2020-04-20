Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1911B0713
	for <lists+linux-api@lfdr.de>; Mon, 20 Apr 2020 13:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgDTLNX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 20 Apr 2020 07:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725775AbgDTLNX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 20 Apr 2020 07:13:23 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00B8C061A0C;
        Mon, 20 Apr 2020 04:13:22 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id k22so2662852eds.6;
        Mon, 20 Apr 2020 04:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=SU+exM0frj/6t8JtBnEfj4oNwFAq7tpryj73d9QgO7s=;
        b=CmwvVqcIh5/X/TwkuiTz7oED/QQIDxkPArBQBAkOQ0p8fNyynbyBnMPnd3RhuBEajn
         U4GWho+n9f9Rfqss6dv56RQGO43QRk+0IvkqF+3F60EIVgvoVHvqxzIQA+1THRlAmsTg
         /smH4bTnw/yey2GVNZ0v/3tPg1tuu8quk9zLldmPfF5vAsaJdcPsl8NpTQpPMOiyn29s
         HcRTEAAk3im21L0svXMK8CAqbaoSZjkoDSs0n1amjrW113NgAyjzuBtuNKMe0poSUYbC
         Lr32Xgt05WNOQTc3vROH8LK/OefQoQYEhmjUttxDNxMDlHtRCYBwKqFJ+Aucq4XSwWtt
         QS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=SU+exM0frj/6t8JtBnEfj4oNwFAq7tpryj73d9QgO7s=;
        b=aci76wfolfW74Zedt7gZS9VujEzopQOhRkF9cqtyf4nbFKsZjWTzIO37ubUIak2rGm
         ExDXliSpNT5CHan+pnDwjl/vJ3Hc7BPfNGi1CmQcoVDQSeL96TZBYPc5Heb7jXjFm/SZ
         Oi5H929QSjT2gF7qG6YI53LOBgOG/IPveH8gtscNHiC9KeG3mA5eNJzmCC3D8tXgxr9F
         /eKLHYubLEegeb8UOJVpf2U31FWh5qJaFK2JA2zk2sQ7oPVPeOFZTn7NeBYjoCCTx5jH
         I/btyuMipQIvHgKKGLUjTZkAl3SD27d8O64ZlY8+8iqR89P1153y7BXecUCG2b/zxvuk
         D6Ug==
X-Gm-Message-State: AGi0PuZ/scXskfdvFDyjuUGMI0hyIxZWxjAw0pFZDc9KBlBy0IgEoJDX
        FemhqtX6jColBETuoRPoQKm4eOrauEnfomWpDe8=
X-Google-Smtp-Source: APiQypJMFl8usNxelAB+tiyORrTHtguqC8wphidrmECUaKOO5gezxw+Kp4StaDvHfPfsEXkfbdwfp+N+eIdquzx6QzU=
X-Received: by 2002:a05:6402:16da:: with SMTP id r26mr13054459edx.375.1587381201259;
 Mon, 20 Apr 2020 04:13:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAKgNAkiTYY3mrdsWypX22WCczVK9GDsOO-Vq58go_b2=719=FA@mail.gmail.com>
 <ce049b034919c4a09629c2e7bec574af133fb064.1585837173.git.e@nanocritical.com>
 <CA+zRj8XYLpa_gep+VxUfQuqeKu+=thMit-jNv1soC8Mh5H43Ug@mail.gmail.com>
 <CAKgNAkipcX47quv23SACeorSexO00nUAJR3QSTA3bFNMresE4Q@mail.gmail.com> <CA+zRj8XzqV19Z9KcyO+_V2Nkt4fgwK7QbP01GE5EL=g_xHf8Xw@mail.gmail.com>
In-Reply-To: <CA+zRj8XzqV19Z9KcyO+_V2Nkt4fgwK7QbP01GE5EL=g_xHf8Xw@mail.gmail.com>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Mon, 20 Apr 2020 13:13:09 +0200
Message-ID: <CAKgNAkgxYf7tJMU5T=h_2aEweF28p-pCMUoF5gMkxv9jGMXZtg@mail.gmail.com>
Subject: Re: [PATCH 1/1] clock_getres.2: dynamic POSIX clock devices can
 return other errors
To:     Eric Rannaud <eric.rannaud@gmail.com>
Cc:     Eric Rannaud <e@nanocritical.com>,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello Eric,

> > > (IEEE 1588 PTP is the canonical user of these dynamic clock devices)
> > >
> > > Would you want to refer to any of these from the man page?
> >
> > See above. I would be happy to add a 2 or 3 sentence note to the page
> > that briefly describes the concept of a POSIX clock. Would you be able
> > to come up with something?
>
> I'll try, but I've never used them, so I'm not convinced I can capture
> the concept clearly.

Cough! I found an old patch in my inbox...

https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/commit/?id=f377393edddb6321a53c3e5ba516977e04d10445
(plus some edits in some subsequent commits)

Thanks,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
