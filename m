Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3969437854
	for <lists+linux-api@lfdr.de>; Thu,  6 Jun 2019 17:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbfFFPmc (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 6 Jun 2019 11:42:32 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:33302 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729287AbfFFPmc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 6 Jun 2019 11:42:32 -0400
Received: by mail-pg1-f173.google.com with SMTP id h17so1597453pgv.0
        for <linux-api@vger.kernel.org>; Thu, 06 Jun 2019 08:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ZawA+iZOSJAZNtAUyoJ3pGc/N5S/i87IWFfgocy0e+s=;
        b=RLesCpt3QeyWEIityCf0prUXi0LRvr0YMT/HyZcUK86bCo5bvZOmir/9zeekSwtEJ3
         tMmnodU5jetOGs7/jE1WKnIWyyl6exkggpGq0cZctOt0K3MLrBn+ueiy43oGPG5d/I7r
         dJO3VE82qQWYGkL+2V3ss/I8DaSATaouxHEvStXqE+lG1eP/P4e9OLNLPRDrnuLL0hGs
         9jzbUZgkSKsFRuT5kHjdsAMnE7Qw7GKrRB9X+BFaQ37BYGsytof+PGsJFaKzQE0RAckY
         uc4MH7D5JdTzuGmeyu9Kn5uwJj3711Og+VZ5JDhQjLTC3DHiZ7JoqLncIwa6YdyOddoI
         fRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ZawA+iZOSJAZNtAUyoJ3pGc/N5S/i87IWFfgocy0e+s=;
        b=YAA2QfCrTmJH7VUNuIqCFmYFAF99RjFY+wc+d6atUwYT5jqMepjuXOkwmzY6tSyB/d
         AccZH4earARHbaEnYv1STVBGUfI0RDmC2baNHYaIxa/0ItaWXrKw9LHCYlpfWhnsEteO
         aowM+wZkjMBh8KZ1FJehFmSuH59EeQTVZfjs88Xw8cnHhqrAXw41OeknppCGhq6GxBAa
         f3v1/C6EarEf+nC/bSHIdFfUpT4npI+mcXq2h03M3hbeUzQ8f85nZm5Jv0vKu2Hu3p9g
         h7EyR7/i6FjKJqU0ByfvL0DuuarQsu9Mdo91DMJBW00CfnVWi8Vt9puoP1z3uFwnkLXS
         VzGQ==
X-Gm-Message-State: APjAAAWEwdXHqTOGH24Db9otborPLq5N4xVLZJW3qEFaViZgG6WjlP1X
        Q9k4AByAN70zFW6nKzSiuiDXXhARd/8vnQ==
X-Google-Smtp-Source: APXvYqx4kogHKk/c2Boqg6sX1qyQ7RBmEFL2JMtOpkKE1hecf4opydsz9GCyAfdl1db+YN88h61G2Q==
X-Received: by 2002:a17:90a:a415:: with SMTP id y21mr501016pjp.75.1559835751297;
        Thu, 06 Jun 2019 08:42:31 -0700 (PDT)
Received: from brauner.io ([172.56.30.175])
        by smtp.gmail.com with ESMTPSA id 85sm2373269pgb.52.2019.06.06.08.42.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 08:42:30 -0700 (PDT)
Date:   Thu, 6 Jun 2019 17:42:25 +0200
From:   Christian Brauner <christian@brauner.io>
To:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC]: Convention for naming syscall revisions
Message-ID: <20190606154224.7lln4zp6v3ey4icq@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hey everyone,

I hope this is not going to start a trash fire.

While working on a new clone version I tried to find out what the
current naming conventions for syscall revisions is. I was told and
seemed to be able to confirm through the syscall list that revisions of
syscalls are for the most part (for examples see [1]) named after the
number of arguments and not for the number of revisions. But some also
seem to escape that logic (e.g. clone2).

In any case, I would like to document *a* convention for syscall
revisions on https://www.kernel.org/doc/ . So what shall it be:
- number of args
- number of revision
?

Christian

[1]: - accept4(/* 4 args */)
     - dup2(/* 2 args */)
     - dup3(/* 3 args */)
     - eventfd2(/* 2 args */)
     - pipe2(/* 2 args */)
     - pselect6(/* 6 args, including structs */)
     - signalfd4(/* 4 args, one of them a struct */)
     - umount2(/* 2 args */)
     - wait3(/* 3 args, one of them a struct */)
     - wait4(/* 4 args, one of them a struct */)
