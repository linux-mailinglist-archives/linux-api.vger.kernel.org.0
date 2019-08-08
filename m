Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 121D9868CA
	for <lists+linux-api@lfdr.de>; Thu,  8 Aug 2019 20:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389883AbfHHSbW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 8 Aug 2019 14:31:22 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34566 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389803AbfHHSbV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 8 Aug 2019 14:31:21 -0400
Received: by mail-ot1-f67.google.com with SMTP id n5so122609188otk.1
        for <linux-api@vger.kernel.org>; Thu, 08 Aug 2019 11:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3rtv12HMfSH1D6p3ex9Lyt90UEVGyLsKWezm6chHT9A=;
        b=Fy+mcdgGF1HsiFc0TDdVGK0VRkPzdwcSw2bdeX0q/LcEmOoX4UWJo261S4sTNtXb8i
         xi7isPO6UGweXoy8UowH7HGPwaIdB7xKGK0peBhMf4rrcnKG1Pc7k/kuVLmXyJDFXr49
         dnV+6E8OeEL1YA9mFq4qj6wtdq11bJU9LN3YqIDVlc1vjCP/DpTxDjQQrGVPHd2JIniS
         wY3LJsYpctZDt+5lLo0Ir7QMYvtpyseoqGHpW5SCs/+4h0z0ErqYypINRRkHbBacD7it
         CU73H/EMss8E0ionfShh0Y2KPn+m/5h1xmbinM8zW0JY3avRjiDF0HPBmq7CmqovdNrJ
         21TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3rtv12HMfSH1D6p3ex9Lyt90UEVGyLsKWezm6chHT9A=;
        b=TKUpEzMbJBDfKkwzS2JxhuND4HHAUZgFstM/uJFvD/jhIS2PxPbvYaIxjjzwo9M4Dn
         JoBZYbMl8yuk4UaOMp+/bqR/di4wv4LCfZSuzETEhwyosz4/CS85eVnaNdEsQ7LYkmgc
         trQXDOfIxzzNxRIVlGlruM8Q3WRiggrPQh06ExmnDkv7wjl9lFj/LngnOvxphni1J28I
         P+36vKDprhNIwENPuhMXrtDiDcKAyryNFzK6iwaUo6nlNJxYrct0yWoeiKZt4+/P+LCD
         Q7OK0B0LgT2HTJ09DNkaTIKZL58BBR+w+5amp0WzIhsV3gJeWNQm86z+ep7D1OZxYkD3
         Wrfw==
X-Gm-Message-State: APjAAAX/UCfkzI9/K2efrZX0dCnKdoUJEyaig7zRH/a4fjUtXbSN7raY
        LWGGiSayrC4cz2P5o4PzX1jGXVyLi4RJmvLxtsOP3Q==
X-Google-Smtp-Source: APXvYqy1GWE+DCjcOOXGruY8e+wtqixswfDkOLrxf+7k5L/2ZdKr2V07b6+07F/iK1zBiyy9w1Ye4cSOOEQWFLUqSe0=
X-Received: by 2002:a5e:9404:: with SMTP id q4mr2188207ioj.46.1565289080794;
 Thu, 08 Aug 2019 11:31:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190731221617.234725-1-matthewgarrett@google.com>
 <20190731221617.234725-5-matthewgarrett@google.com> <20190801142157.GA5834@linux-8ccs>
 <CACdnJusD_9W9tFqwKptDTA8fZU8HrSvsEQhKo0WS9QxLpgz5tA@mail.gmail.com> <20190808100059.GA30260@linux-8ccs>
In-Reply-To: <20190808100059.GA30260@linux-8ccs>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 8 Aug 2019 11:31:09 -0700
Message-ID: <CACdnJuu6gFQUQQOVj2MwL5+dx+XsBKY=Uq58r7F8Lr2C0Gi_TA@mail.gmail.com>
Subject: Re: [PATCH V37 04/29] Enforce module signatures if the kernel is
 locked down
To:     Jessica Yu <jeyu@kernel.org>
Cc:     James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Aug 8, 2019 at 3:01 AM Jessica Yu <jeyu@kernel.org> wrote:
> If you're confident that a hard dependency is not the right approach,
> then perhaps we could add a comment in the Kconfig (You could take a
> look at the comment under MODULE_SIG_ALL in init/Kconfig for an
> example)? If someone is configuring the kernel on their own then it'd
> be nice to let them know, otherwise having a lockdown kernel without
> module signatures would defeat the purpose of lockdown no? :-)

James, what would your preference be here? Jessica is right that not
having CONFIG_MODULE_SIG enabled means lockdown probably doesn't work
as expected, but tying it to the lockdown LSM seems inappropriate when
another LSM could be providing lockdown policy and run into the same
issue. Should this just be mentioned in the CONFIG_MODULE_SIG Kconfig
help?
