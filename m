Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72D6A51C1C
	for <lists+linux-api@lfdr.de>; Mon, 24 Jun 2019 22:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731575AbfFXUP5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 24 Jun 2019 16:15:57 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41964 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731567AbfFXUP5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 24 Jun 2019 16:15:57 -0400
Received: by mail-io1-f66.google.com with SMTP id w25so4443256ioc.8
        for <linux-api@vger.kernel.org>; Mon, 24 Jun 2019 13:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NlNgzMMFJ+7QwGx9xG98XqTbQWSzsaaFAnhIGC2h2XQ=;
        b=NJGAPTmUam9+dMN0mbGC1vA6isBRugH0cJzAQU6FeessvYEf6yigBykoLNvckboO3/
         RxDkBfqV+yw42M+bQIm97RifrnkhMUPvAAhuDM72zLT4jB3DygRAWDY59fcJKHsJPX2+
         3+d2DIKgFvXJaFL9EUuz/R7kelADr+QazYAQ02FtZ4tYF2V/ieg29/jq+Lvo9zI/MXda
         IdSWU6kcTBgiUoXi9HmdgUEQdKeV09YSt0GzBD61kq1idQba5fMW/q+ThWkqOYpA32AK
         92iFCn9RLi7EPpKuHTMTDKtB7kwTJcG4gFeNJwNP/zH/FEuLdiZkDxl404taFXuSNC2Q
         E50Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NlNgzMMFJ+7QwGx9xG98XqTbQWSzsaaFAnhIGC2h2XQ=;
        b=laDIbSE9ls6KsR+sGJob0ca1HRicCCree/D9VIP8qy6esPFB8N+rDtndcfIiOCcoVG
         /a76aiEontrGCiPs4rf3GGt99coblR2YYN3QILrIfkSNPHJJNFP5GnTs5vr2VUh/yLGy
         wBVVF++QKAL5ASSYX8PFZkQBt7V7RBP7y7awLhwZrQpc8YQ+FOWqUbQE9zjH3f3Ggkgp
         doYnOuLyi6zhLNB6ZWGJ1xiig9Bj95R2Vc42y4YLTYdhg8zDd5pTs8SbOvdHO4atVvJs
         EtogButu1wDO46wK1sFQyr6wdr25rWMlxvkTUQE7OmP9dUzA25aQV/6Q+MHb6s/Ui7zd
         KMbg==
X-Gm-Message-State: APjAAAWG3GliCVM/beI3geidZ4WBzq+L8Eb25ibgdf6IWV9N0KEq4LBf
        JAvs0FGXrPpzTcQ/j0rV1KY+9HoJYjicx3FLECSfCQ==
X-Google-Smtp-Source: APXvYqyqE/v1ofHO2nNCjIkljvgKCheFXksKQ8Ljlo0aFkiv1nRWwX6SmmK6XsZCfnY2ySNNRxkFfbK1mnYl9RNm7VA=
X-Received: by 2002:a5d:9d97:: with SMTP id 23mr2139870ion.204.1561407356312;
 Mon, 24 Jun 2019 13:15:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190622000358.19895-1-matthewgarrett@google.com>
 <20190622000358.19895-24-matthewgarrett@google.com> <739e21b5-9559-d588-3542-bf0bc81de1b2@iogearbox.net>
 <CACdnJuvR2bn3y3fYzg06GWXXgAGjgED2Dfa5g0oAwJ28qCCqBg@mail.gmail.com> <CALCETrWmZX3R1L88Gz9vLY68gcK8zSXL4cA4GqAzQoyqSR7rRQ@mail.gmail.com>
In-Reply-To: <CALCETrWmZX3R1L88Gz9vLY68gcK8zSXL4cA4GqAzQoyqSR7rRQ@mail.gmail.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 24 Jun 2019 13:15:44 -0700
Message-ID: <CACdnJuu20Rsb-9XAcTR5Q9RJ5wY7ATazS7dLgDODH+YSZU50Tg@mail.gmail.com>
Subject: Re: [PATCH V34 23/29] bpf: Restrict bpf when kernel lockdown is in
 confidentiality mode
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        Chun-Yi Lee <jlee@suse.com>, Jann Horn <jannh@google.com>,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jun 24, 2019 at 1:09 PM Andy Lutomirski <luto@kernel.org> wrote:

> I'm confused.  I understand why we're restricting bpf_probe_read().
> Why are we restricting bpf_probe_write_user() and bpf_trace_printk(),
> though?

Hmm. I think the thinking here was around exfiltration mechanisms, but
if the read is blocked then that seems less likely. This seems to
trace back to http://kernsec.org/pipermail/linux-security-module-archive/2017-October/003545.html
- Joey, do you know the reasoning here?
