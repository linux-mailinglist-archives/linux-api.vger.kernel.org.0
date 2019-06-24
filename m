Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAB351F57
	for <lists+linux-api@lfdr.de>; Tue, 25 Jun 2019 01:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbfFXX4j (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 24 Jun 2019 19:56:39 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44145 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbfFXX4i (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 24 Jun 2019 19:56:38 -0400
Received: by mail-io1-f68.google.com with SMTP id s7so867137iob.11
        for <linux-api@vger.kernel.org>; Mon, 24 Jun 2019 16:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qbOrnIupVUW58CvYWuTxi+TaCWansJx4UnWPnwoZyJY=;
        b=HUXUAlmqADW2TvklcTS8vLxmQ564rKI+gpHW3ckU8mFGROi3j1s/fMq9zvwOcD+GR/
         Ejy70MnCirzz9M9UbGuGbPLeezKbqoKj5JhUclzQLUQP28sgxW820TLZ5lbacxE8hQVj
         x4uw9hzl639jgHDZ9UO3wpxo8Un3RGw4P0LCSzGhvIDVlg6UdGz3N8h2s5TUacfgJvvt
         Pfjo3cZvMqWAUxDZP8GviI08ewLTXJMN/ALlSa5C0CgSVWdjy2beq6N+kPRv2Nus+C56
         PN1V00fo3fGRDTYnUHm3vvref5BiDeYLvYvEoZngc27qwYQ8qOB4lozFsNR4aA/IipUt
         kA4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qbOrnIupVUW58CvYWuTxi+TaCWansJx4UnWPnwoZyJY=;
        b=B/GG+MK9xHRmbA4simvzDO7g58RLELOAQiAaDGxnQlNShhXlRAuDvGAKSDTPQxxCCQ
         knhWx8TNybAWJXF5BI/W93xKQjL0bcs4jVZOyap+Px4e5/jCtSfaaHgfzspsyXQtIz/A
         0Y7RQquwEkgepwn5JPXwLJRE+R5TkYkXBIP3cderBiJJW83sx2AjcwhRhzbUazwtc6vH
         TT0KcSKw1m4qPRPYZjIIS9ntHrsq2sV5Yn1RGp/j1ZaIgkfEe6ZPjbMdBLF+SZmuQ6Be
         OePWZfUcVc9rqzwTkj3d3jsQD+KT1NenrXRvCINYXc7kbIide7A+2bcT0sBO39OZ7bzm
         JrbA==
X-Gm-Message-State: APjAAAV6+RD9DHodEsRlNXVbVBIzXpufGdD2QTz1s3tZODNzh6+LpIel
        mZ978onv6o3ZJkkXfodBmM8apUYeemyn4EqA/zplGw==
X-Google-Smtp-Source: APXvYqyJ78ZTsA34HUGlgKawtoKMfnBRG3TGL+IoK1XwzWW+xnzC8aP35qDBpYttWG4XrxgtQu1mEyJbU+viiisuDtA=
X-Received: by 2002:a6b:8dcf:: with SMTP id p198mr8001652iod.46.1561420597592;
 Mon, 24 Jun 2019 16:56:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190622000358.19895-1-matthewgarrett@google.com> <alpine.LRH.2.21.1906250853290.7826@namei.org>
In-Reply-To: <alpine.LRH.2.21.1906250853290.7826@namei.org>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 24 Jun 2019 16:56:25 -0700
Message-ID: <CACdnJut2erF9ZKeJQ+uvWZeEnHh=stmEioi_P36DF9mN5i2RGQ@mail.gmail.com>
Subject: Re: [PATCH V34 00/29] Lockdown as an LSM
To:     James Morris <jmorris@namei.org>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Andy Lutomirski <luto@amacapital.net>,
        John Johansen <john.johansen@canonical.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jun 24, 2019 at 4:01 PM James Morris <jmorris@namei.org> wrote:
>
> On Fri, 21 Jun 2019, Matthew Garrett wrote:
>
> > Minor updates over V33 - security_is_locked_down renamed to
> > security_locked_down, return value of security_locked_down is returned
> > in most cases, one unnecessary patch was dropped, couple of minor nits
> > fixed.
>
> Thanks for the respin.
>
> We are still not resolved on granularity. Stephen has said he's not sure
> if a useful policy can be constructed with just confidentiality and
> integrity settings. I'd be interested to know JJ and Casey's thoughts on
> lockdown policy flexibility wrt their respective LSMs.

This implementation provides arbitrary granularity at the LSM level,
though the lockdown LSM itself only provides two levels. Other LSMs
can choose an appropriate level of exposure.

> These are also "all or nothing" choices which may prevent deployment due
> to a user needing to allow (presumably controlled or mitigated) exceptions
> to the policy.

Distributions have been deploying the "all or nothing" solution for
several years now, which implies that it's adequate for the common
case. I think it's reasonable to punt finer grained policies over to
other LSMs - people who want that are probably already using custom
LSM policy.
